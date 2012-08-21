class FinancialReportController < ApplicationController
  def index
  end

  def cash_flow_filter
    @filter = { :balance => 0.00 }
    BankAccount.all.each do |ba|
      @filter[:balance] += ba.total.to_f
    end
  end

  def cash_flow_show
    @filter = params[:flow]
    @cash_flow = VwCashFlow.find(:all, :conditions => ["date >= ? And date <= ?", @filter[:starts_at], @filter[:ends_at]])
  end

  def expenditure_filter
  end

  def expenditure_show
    @filter = params[:expenditure]
    @ap_pay = AccountPlan.report_payables    @filter[:starts_at], @filter[:ends_at]
  end

  def sales_filter
  end

  def sales_show
    @filter = params[:sales]
    @ap_rec = AccountPlan.report_receivables @filter[:starts_at], @filter[:ends_at]
  end

  def account_plan_filter
  end

  def account_plan_show
    @filter = params[:plan]
    @ap_rec = AccountPlan.report_receivables @filter[:starts_at], @filter[:ends_at]
    @ap_pay = AccountPlan.report_payables    @filter[:starts_at], @filter[:ends_at]
    @rec_total = Receivable.total_behind_due_date(@filter[:starts_at], @filter[:ends_at])[0].total.to_f
  end

end
