require 'ap'
class ReceivableBilling < ActiveRecord::Base
  belongs_to :receivable
  attr_accessor :settle_receivable

  after_save :settle_receivable!

  def client
    receivable.client if client_id
  end

  private
  # quita recebimento
  def settle_receivable!
    if settle_receivable == "1" || self.receivable.reached_limit?
      r = Receivable.find(receivable_id)
      r.settled = true
      r.save
    end
  end
end
