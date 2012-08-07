class CreateAccountPlanFunctions < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      Create Function fn_accountPlan_getCodeLevel (code VarChar(11), level Integer)
      Returns VarChar(11)
      Return Left(code, level * 3);
    SQL

    execute <<-SQL
      Create Function fn_accountPlan_sumSynthetic (code VarChar(11), level Integer)
      Returns Decimal(10,2)
      Return (Select Sum(spcd.value) As value
              From account_plans  sacp
              Left Join payable_cost_divisions spcd On spcd.account_plan_id = sacp.id
              Where sacp.analytical Is True
              And sacp.code Like Concat(fn_accountPlan_getCodeLevel(code, level),'%') Collate utf8_unicode_ci
              Order By sacp.code);
    SQL
  end

  def self.down
    execute "Drop Function fn_accountPlan_getCodeLevel"
    execute "Drop Function fn_accountPlan_sumSynthetic"
  end
end
