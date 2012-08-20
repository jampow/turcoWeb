class BankAccountTransaction < ActiveRecord::Base
  validates_presence_of :date
  validate :presence_of_value

  belongs_to :bank_account

#   Select ba.*
#        , (Select IfNull(Sum(sba.credit),0.00) - IfNull(Sum(sba.debit),0.00)
#             From bank_account_transactions sba
#            Where sba.date <= ba.date
#              And sba.id <= ba.id
#              And sba.bank_account_id = ba.bank_account_id) As Balance
#     From bank_account_transactions ba
#    Where ba.bank_account_id = 1
# Order by ba.date

  named_scope :transactions, lambda { |bank_account_id| {
    :select     => " ba.*, (Select IfNull(Sum(sba.credit),0.00) - IfNull(Sum(sba.debit),0.00) From bank_account_transactions sba Where sba.date <= ba.date And sba.id <= ba.id And sba.bank_account_id = ba.bank_account_id) As balance",
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

protected

  def presence_of_value
    errors.add_to_base("Adicione um valor de débito ou crédito") if debit.blank? && credit.blank?
  end
end
