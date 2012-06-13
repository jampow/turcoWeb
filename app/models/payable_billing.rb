class PayableBilling < ActiveRecord::Base
  belongs_to :payable
  attr_accessor :settle_payable

  after_save :settle_payable!

  def client
    payable.client if client_id
  end

  private
  # quita recebimento
  def settle_payable!
    if settle_payable == "1" || self.payable.reached_limit?
      logger.info "entrou"
      r = Payable.find(payable_id)
      r.settled = true
      r.save
    end
  end
end
