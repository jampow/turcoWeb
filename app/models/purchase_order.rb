class PurchaseOrder < Order
  belongs_to :client

  validates_presence_of :client_id
end
