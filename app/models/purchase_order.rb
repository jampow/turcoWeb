class PurchaseOrder < Order
  belongs_to :provider, :foreign_key => "client_id"

  validates_presence_of :client_id
  
  attr_accessor :provider_name

  before_save :get_next_number

  def get_next_number
    self.number ||= PurchaseOrder.number.next
  end

  def self.number
    self.find(:first, :select => "IfNull(Max(number), 0) As last, IfNull(Max(number), 0)+1 As next", :conditions => "type = 'PurchaseOrder'")
  end
end
