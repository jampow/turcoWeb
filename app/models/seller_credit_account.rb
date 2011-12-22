class SellerCreditAccount < ActiveRecord::Base
  belongs_to :seller

#   Select ca.*
#        , (Select Sum(sca.credit) - Sum(sca.debit)
#             From seller_credit_accounts sca
#            Where sca.date <= ca.date
#              And sca.seller_id = ca.seller_id) As Balance
#     From seller_credit_accounts ca
#    Where ca.seller_id = 2
# Order by ca.date

  named_scope :credit_accounts, lambda { |seller_id| {
    :select     => "ca.*, (Select Sum(sca.credit) - Sum(sca.debit) From seller_credit_accounts sca Where sca.date <= ca.date And sca.seller_id = ca.seller_id) As balance",
    :joins      => "ca",
    :conditions => ["ca.seller_id = ?", seller_id],
    :order      => "ca.date"}
  }
end
