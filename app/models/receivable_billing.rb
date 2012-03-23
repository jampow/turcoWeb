class ReceivableBilling < ActiveRecord::Base
  belongs_to :receivable
  attr_accessor :settle_receivable

  after_save :settle_receivable!

  private
  def settle_receivable!
    if settle_receivable
      receivable.settled = true
      receivable.save
    end
  end
end
