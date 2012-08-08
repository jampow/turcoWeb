class FinancialReportController < ApplicationController
  def index
  end

  def cash_flow_filter
  end

  def cash_flow_show
    @filter = params[:flow]
    @cash_flow = VwCashFlow.find(:all, :conditions => ["date >= ? And date <= ?", @filter[:starts_at], @filter[:ends_at]])
  end

  def account_plan_filter
  end

  def account_plan_show
    @filter = params[:plan]
    @ap_rec = AccountPlan.report_receivables @filter[:starts_at], @filter[:ends_at]
    @ap_pay = AccountPlan.report_payables    @filter[:starts_at], @filter[:ends_at]
  end

end
