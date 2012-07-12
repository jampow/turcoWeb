class ReceivableBilling < ActiveRecord::Base
  belongs_to :receivable
  attr_accessor :settle_receivable

  after_save :settle_receivable!
  validates_presence_of :received_at, :value

  def client
    receivable.client if client_id
  end

  private
  # quita recebimento
  def settle_receivable!
    if settle_receivable == "1" || self.receivable.reached_limit?
      r = Receivable.find(receivable_id)
      r.settled = true
      r.payment_date = received_at
      r.save

      BankAccountTransaction.create(:bank_account_id => self.bank_account_id,
                                    :name            => "<a href=\"/receivables/#{r.id}\">Cobrança ##{r.id}</a>" ,
                                    :historic        => "Recebimento da cobrança ##{r.id}" ,
                                    :credit          => self.total,
                                    :date            => Date.today )
    end
  end
end
