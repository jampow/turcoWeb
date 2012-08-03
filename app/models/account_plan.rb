class AccountPlan < ActiveRecord::Base
  validates_presence_of :name, :code, :level
  validate :synthetic_with_apportionments
  validates_numericality_of :level, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 4
  validates_uniqueness_of :code

  has_many :apportionments
  has_many :cost_centers, :through => :apportionments
  before_save :mark_item_for_removal

  accepts_nested_attributes_for :apportionments, :reject_if => proc { |a| a[:cost_center_name].blank? || a[:rate].blank?}

  def self.to_select
    self.all.map { |v| [ v[:name], v[:id] ] }
  end

  protected

  def synthetic_with_apportionments
    errors.add_to_base("Conta sintética não pode ter rateamento. Apague os itens do rateamento ou marque a conta como analítica.") if analytical == false && apportionments.length > 0
  end

  def mark_item_for_removal
    apportionments.each do |child|
      child.mark_for_destruction if child.cost_center_name.blank? || child.rate.blank?
    end
  end
end
