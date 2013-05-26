class AccountPlan < ActiveRecord::Base
  validates_presence_of :name, :code, :level
  validate :synthetic_with_apportionments
  validates_numericality_of :level, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 4
  validates_uniqueness_of :code

  has_many :apportionments
  has_many :cost_centers, :through => :apportionments
  before_save :mark_item_for_removal
  before_save :validates_uniqueness_of_default

  accepts_nested_attributes_for :apportionments, :reject_if => proc { |a| a[:cost_center_name].blank? || a[:rate].blank?}

  def self.to_select
    self.all.map { |v| [ v[:name], v[:id] ] }
  end

  def has_valid_apportionments?
    ret = false
    apportionments.each { |item| ret = true if !item.cost_center_name.blank? && !item.rate.blank? }
    ret
  end

  protected

  def synthetic_with_apportionments
    errors.add_to_base("Conta sintética não pode ter rateamento. Apague os itens do rateamento ou marque a conta como analítica.") if analytical == false && has_valid_apportionments?
  end

  def mark_item_for_removal
    apportionments.each do |child|
      child.mark_for_destruction if child.cost_center_name.blank? || child.rate.blank?
    end
  end

  def validates_uniqueness_of_default
    if self.default
      todisable = AccountPlan.find_by_orientation_id_and_default(self.orientation_id, true)
      if !todisable.nil?
        todisable.default = false
        todisable.save!
      end
    end
  end

  class Orientation <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Contas a receber'},
      {:id => 2, :name => 'Contas a pagar'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end

  named_scope :grid, :select => "id, code, name, `default`, analytical, if(orientation_id = 1, 'a receber', 'a pagar') As orientation"

  # Select acp.code
  #      , Concat(Repeat('&nbsp;&nbsp;&nbsp;', acp.level - 1), acp.name) As name
  #      , acp.level
  #      , If(acp.analytical
  #         , fn_accountPlan_sumAnalyticPayables(acp.code, '2012-07-01', '2012-08-01')
  #         , fn_accountPlan_sumSyntheticPayables(acp.code, acp.level, '2012-07-01', '2012-09-01')) As value
  # From account_plans acp
  # Where acp.orientation_id = 2
  # Group By code, name, level

  named_scope :report_payables, lambda { |start_date, end_date| {
                                :select => "acp.code, Concat(Repeat('&nbsp;&nbsp;&nbsp;', acp.level - 1), acp.name) As name, acp.level, If(acp.analytical, fn_accountPlan_sumAnalyticPayables(acp.code, '#{start_date}' , '#{end_date}'), fn_accountPlan_sumSyntheticPayables(acp.code, acp.level, '#{start_date}' , '#{end_date}')) As value",
                                :joins  => "acp",
                                :conditions => "acp.orientation_id = 2",
                                :group => "code, name, level",
                                :order => "code"
                              } }

  # Select acp.code
  #      , Concat(Repeat('&nbsp;&nbsp;&nbsp;', acp.level - 1), acp.name) As name
  #      , acp.level
  #      , If(acp.analytical
  #         , fn_accountPlan_sumAnalyticReceivables(acp.code, '2012-07-01', '2012-09-01')
  #         , fn_accountPlan_sumSyntheticReceivables(acp.code, acp.level, '2012-07-01', '2012-09-01')) As value
  # From account_plans acp
  # Where acp.orientation_id = 1
  # Group By code, name, level
  # Order By code;

  named_scope :report_receivables, lambda { |start_date, end_date| {
                                :select => "acp.code, Concat(Repeat('&nbsp;&nbsp;&nbsp;', acp.level - 1), acp.name) As name, acp.level, If(acp.analytical, fn_accountPlan_sumAnalyticReceivables(acp.code, '#{start_date}', '#{end_date}'), fn_accountPlan_sumSyntheticReceivables(acp.code, acp.level, '#{start_date}', '#{end_date}')) As value",
                                :joins  => "acp",
                                :conditions => "acp.orientation_id = 1",
                                :group => "code, name, level",
                                :order => "code"
                              } }

end
