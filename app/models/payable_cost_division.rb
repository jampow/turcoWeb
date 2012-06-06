class PayableCostDivision < ActiveRecord::Base
  attr_accessor :account_plan_name, :cost_center_name, :percent
  belongs_to :account_plan
  belongs_to :cost_center

  def after_initialize
  	self.account_plan_name = AccountPlan.find(self.account_plan_id, :select => 'name').name if self.account_plan_id
  	self.cost_center_name  = CostCenter.find( self.cost_center_id , :select => 'name').name if self.cost_center_id
  	# self.percent =
  end

end
