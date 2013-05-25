class RedefineAccountPlanFunctions < ActiveRecord::Migration
  def self.up
    execute "Drop Function fn_accountPlan_sumAnalyticPayables;"
    execute "Drop Function fn_accountPlan_sumSyntheticPayables"
    execute "Drop Function fn_accountPlan_sumAnalyticReceivables;"
    execute "Drop Function fn_accountPlan_sumSyntheticReceivables"

    execute <<-SQL
      Create Function fn_accountPlan_sumAnalyticPayables (code VarChar(11), startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select Sum(pcd.value) as value
              From payable_cost_divisions pcd
              Join payables               pay On pay.id = pcd.payable_id
              Join account_plans          acp On acp.id = pcd.account_plan_id
              Where pay.issue_date >= startdate And pay.issue_date <= enddate
              And acp.code = code);
    SQL

    execute <<-SQL
      Create Function fn_accountPlan_sumSyntheticPayables (code VarChar(11), level Integer, startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select Sum(spcd.value) As value
              From account_plans  sacp
              Left Join payable_cost_divisions spcd On spcd.account_plan_id = sacp.id
              Left Join payables spay On spay.id = spcd.payable_id
              Where sacp.analytical Is True
              And sacp.code Like Concat(fn_accountPlan_getCodeLevel(code, level),'%') Collate utf8_unicode_ci
              And spay.issue_date >= startdate And spay.issue_date <= enddate
              Order By sacp.code);
    SQL

    execute <<-SQL
      Create Function fn_accountPlan_sumAnalyticReceivables (code VarChar(11), startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select Sum(rcd.value) as value
              From receivable_cost_divisions rcd
              Join receivables               rec On rec.id = rcd.receivable_id
              Join account_plans             acp On acp.id = rcd.account_plan_id
              Where rec.issue_date >= startdate And rec.issue_date <= enddate
              And acp.code = code);
    SQL

    execute <<-SQL
      Create Function fn_accountPlan_sumSyntheticReceivables (code VarChar(11), level Integer, startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select Sum(srcd.value) As value
              From account_plans  sacp
              Left Join receivable_cost_divisions srcd On srcd.account_plan_id = sacp.id
              Left Join receivables srec On srec.id = srcd.receivable_id
              Where sacp.analytical Is True
              And sacp.code Like Concat(fn_accountPlan_getCodeLevel(code, level),'%') Collate utf8_unicode_ci
              And srec.issue_date >= startdate And srec.issue_date <= enddate
              Order By sacp.code);
    SQL
  end





  def self.down
    execute "Drop Function fn_accountPlan_sumAnalyticPayables;"
    execute "Drop Function fn_accountPlan_sumSyntheticPayables"
    execute "Drop Function fn_accountPlan_sumAnalyticReceivables;"
    execute "Drop Function fn_accountPlan_sumSyntheticReceivables"

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
      Create Function fn_accountPlan_sumSyntheticPayables (code VarChar(11), level Integer, startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select IfNull(Sum(spcd.value), 0.00) As value
              From account_plans  sacp
              Left Join payable_cost_divisions spcd On spcd.account_plan_id = sacp.id
              Left Join payables spay On spay.id = spcd.payable_id
              Where sacp.analytical Is True
              And sacp.code Like Concat(fn_accountPlan_getCodeLevel(code, level),'%') Collate utf8_unicode_ci
              And spay.issue_date >= startdate And spay.issue_date <= enddate
              Order By sacp.code);
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

    execute <<-SQL
      Create Function fn_accountPlan_sumSyntheticReceivables (code VarChar(11), level Integer, startdate Date, enddate Date)
      Returns Decimal(10,2)
      Return (Select IfNull(Sum(srcd.value), 0.00) As value
              From account_plans  sacp
              Left Join receivable_cost_divisions srcd On srcd.account_plan_id = sacp.id
              Left Join receivables srec On srec.id = srcd.receivable_id
              Where sacp.analytical Is True
              And sacp.code Like Concat(fn_accountPlan_getCodeLevel(code, level),'%') Collate utf8_unicode_ci
              And srec.issue_date >= startdate And srec.issue_date <= enddate
              Order By sacp.code);
    SQL
  end
end
