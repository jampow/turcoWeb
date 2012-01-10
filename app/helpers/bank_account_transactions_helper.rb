module BankAccountTransactionsHelper
  
  def btn_transactions(id)
    link_to "Movimentações", "/bank_account_transactions?bank_account_id=#{id}", {:class => "button", :icon => "transferthick-e-w"}
  end
  
end
