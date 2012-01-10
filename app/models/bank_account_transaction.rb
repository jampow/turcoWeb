class BankAccountTransaction < ActiveRecord::Base
  belongs_to :bank_account
  
#   Select ba.*
#        , (Select Sum(sba.credit) - Sum(sba.debit)
#             From bank_account_transactions sba
#            Where sba.date <= ba.date
#              And sba.id <= ba.id
#              And sba.bank_account_id = ba.bank_account_id) As Balance
#     From bank_account_transactions ba
#    Where ba.bank_account_id = 1
# Order by ba.date  

  named_scope :transactions, lambda { |bank_account_id| {
    :select     => " ba.*, (Select Sum(sba.credit) - Sum(sba.debit) From bank_account_transactions sba Where sba.date <= ba.date And sba.id <= ba.id And sba.bank_account_id = ba.bank_account_id) As balance",
    :joins      => "ba",
    :conditions => ["ba.bank_account_id = ?", bank_account_id],
    :order      => "ba.date"}
  }
end
