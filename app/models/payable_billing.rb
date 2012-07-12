class PayableBilling < ActiveRecord::Base
  belongs_to :payable
  attr_accessor :settle_payable

  after_save :settle_payable!

  def provider
    payable.provider if provider_id
  end

  private
  # quita recebimento
  def settle_payable!
    if settle_payable == "1" || self.payable.reached_limit?
      p = Payable.find(payable_id)
      p.settled = true
      p.save

      BankAccountTransaction.create(:bank_account_id => self.bank_account_id,
                                    :name            => "<a href=\"/payables/#{p.id}\">Fatura ##{p.id}</a>" ,
                                    :historic        => "Pagamento da fatura ##{p.id}" ,
                                    :debit           => self.total,
                                    :date            => Date.today )
    end
  end
end
