class CreateAccountPlanFunctions < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      Create Function fn_accountPlan_getCodeLevel (code VarChar(11), level Integer)
      Returns VarChar(11)
      Return Left(code, level * 3);
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

  def self.down
    execute "Drop Function fn_accountPlan_getCodeLevel"
    execute "Drop Function fn_accountPlan_sumSyntheticPayables"
    execute "Drop Function fn_accountPlan_sumSyntheticReceivables"
  end
end
