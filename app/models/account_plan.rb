class AccountPlan < ActiveRecord::Base
  validates_presence_of :name
  has_many :apportionments
  has_many :cost_centers, :through => :apportionments
  
  accepts_nested_attributes_for :apportionments,
                                :allow_destroy => true ,
                                :reject_if => proc { |a| a[:cost_center_name].blank? }
  
  def self.to_select
    self.all.map { |v| [ v[:name], v[:id] ] }
  end
end
