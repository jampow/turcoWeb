class CostCenter < ActiveRecord::Base
  validates_presence_of :name
  has_many :apportionments
  has_many :account_plans, :through => :apportionments

  def self.to_select
    all.map do |cc|
      [cc.name, cc.id]
    end
  end
end
