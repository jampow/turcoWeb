class FinancialReportController < ApplicationController
  def index
  end

  # Fluxo de caixa
  def cash_flow_filter
    @filter = { :balance => 0.00, :starts_at => Date.today.beginning_of_month, :ends_at => Date.today.end_of_month }
    BankAccount.all.each do |ba|
      @filter[:balance] += ba.total.to_f
    end
  end

  def cash_flow_show
    @filter = params[:flow]
    @cash_flow = VwCashFlow.find(:all, :conditions => ["date >= ? And date <= ? And (rec > 0 Or pay > 0)", @filter[:starts_at], @filter[:ends_at]])
  end

  # Despesas
  def expenditure_filter
    @filter = { :starts_at => Date.today.beginning_of_month, :ends_at => Date.today.end_of_month }
  end

  def expenditure_show
    @filter = params[:expenditure]
    @ap_pay = AccountPlan.report_payables    @filter[:starts_at], @filter[:ends_at]
  end

  # Receitas
  def sales_filter
    @filter = { :starts_at => Date.today.beginning_of_month, :ends_at => Date.today.end_of_month }
  end

  def sales_show
    @filter = params[:sales]
    @ap_rec = AccountPlan.report_receivables @filter[:starts_at], @filter[:ends_at]
  end

  # Balancete
  def account_plan_filter
    @filter = { :starts_at => Date.today.beginning_of_month, :ends_at => Date.today.end_of_month }
  end

  def account_plan_show
    @filter = params[:plan]
    @ap_rec = AccountPlan.report_receivables @filter[:starts_at], @filter[:ends_at]
    @ap_pay = AccountPlan.report_payables    @filter[:starts_at], @filter[:ends_at]
    @rec_total = Receivable.total_behind_due_date(@filter[:starts_at], @filter[:ends_at])[0].total.to_f
  end

end
