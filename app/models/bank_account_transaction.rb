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
#   Select ba.bank_account_id
#        , ba.date
#        , Sum(IfNull(debit,0))                         As debit
#        , Sum(IfNull(credit,0))                        As credit
#        , Sum(IfNull(credit,0)) - Sum(IfNull(debit,0)) As daily
#        , (Select Sum(IfNull(sba.credit,0)) - Sum(IfNull(sba.debit,0))
#             From bank_account_transactions sba
#            Where sba.date            <= ba.date
#              And sba.bank_account_id =  ba.bank_account_id) As balance
#     From bank_account_transactions ba
#    Where ba.bank_account_id = 1
#      And ba.date >= '20120621'
#      And ba.date <= '20120622'
# Group By date
# Order By ba.date;

  named_scope :report, lambda { |bank_account_id, starts_at, ends_at|
    cond  = ["ba.bank_account_id = ?", bank_account_id]
    if !starts_at.blank?
      cond[0] += " And ba.date >= ?"
      cond << starts_at
    end
    if !ends_at.blank?
      cond[0] += " And ba.date <= ?"
      cond << ends_at
    end
  {
    :select     => "ba.bank_account_id, ba.date, Sum(IfNull(debit,0)) As debit, Sum(IfNull(credit,0)) As credit, Sum(IfNull(credit,0)) - Sum(IfNull(debit,0)) As daily, (Select Sum(IfNull(sba.credit,0)) - Sum(IfNull(sba.debit,0)) From bank_account_transactions sba Where sba.date <= ba.date And sba.bank_account_id = ba.bank_account_id) As balance",
    :joins      => "ba",
    :conditions => cond,
    :group      => "date",
    :order      => "ba.date"}
  }
end
