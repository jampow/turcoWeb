class CostCenter < ActiveRecord::Base
  validates_presence_of :name
  has_many :apportionments
  has_many :account_plans, :through => :apportionments
end
