class CashFlowController < ApplicationController
  def index
    default_data
  end

  def show
    @filter = params[:flow]
    @cash_flow = VwCashFlow.find(:all, :conditions => ["date >= ? And date <= ?", @filter[:starts_at], @filter[:ends_at]])
    default_data
  end

protected

  def default_data
    # @bank_list = BankAccount.all.collect { |b| [b.to_s, b.id] }
  end



end
