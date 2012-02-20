class PurchaseOrder < Order
  belongs_to :provider, :foreign_key => "client_id"

  validates_presence_of :client_id
  
  attr_accessor :provider_name
end
