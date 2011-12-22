module SellersHelper
  
  def btn_credit_account(id)
    link_to "Conta Corrente", "/seller_credit_accounts?seller_id=#{id}", {:class => "button", :icon => "suitcase"}
  end
  
end
