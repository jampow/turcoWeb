class AccountPlan < ActiveRecord::Base
  validates_presence_of :name
  has_many :apportionments
  has_many :cost_centers, :through => :apportionments
  before_save :mark_item_for_removal

  accepts_nested_attributes_for :apportionments, :reject_if => proc { |a| a[:cost_center_name].blank? || a[:rate].blank?}

  def self.to_select
    self.all.map { |v| [ v[:name], v[:id] ] }
  end

  protected

  def mark_item_for_removal
    apportionments.each do |child|
      child.mark_for_destruction if child.cost_center_name.blank? || child.rate.blank?
    end
  end
end
