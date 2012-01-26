class ReceivableCostDivision < ActiveRecord::Base
  attr_accessor :account_plan_name, :cost_center_name, :percent
  belongs_to :account_plan
  belongs_to :cost_center
end
