class CreateAccountPlanFunctionsTotalByCode < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      Create Function fn_accountPlan_sumAnalyticPayables (code VarChar(11), startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select IfNull(Sum(pcd.value), 0.00) as value
              From payable_cost_divisions pcd
              Join payables               pay On pay.id = pcd.payable_id
              Join account_plans          acp On acp.id = pcd.account_plan_id
              Where pay.issue_date >= startdate And pay.issue_date <= enddate
              And acp.code = code);
    SQL
    execute <<-SQL
      Create Function fn_accountPlan_sumAnalyticReceivables (code VarChar(11), startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select IfNull(Sum(rcd.value), 0.00) as value
              From receivable_cost_divisions rcd
              Join receivables               rec On rec.id = rcd.receivable_id
              Join account_plans          acp On acp.id = rcd.account_plan_id
              Where rec.issue_date >= startdate And rec.issue_date <= enddate
              And acp.code = code);
    SQL
  end

  def self.down
    execute "Drop Function fn_accountPlan_sumAnalyticPayables;"
    execute "Drop Function fn_accountPlan_sumAnalyticReceivables;"
  end
end
