class PurchaseOrder < Order
  belongs_to :provider    , :foreign_key => "client_id"
  belongs_to :payment_form, :foreign_key => "payment_condition_id"
  belongs_to :attendant   , :class_name  => "User"

  validates_presence_of :client_id
  validates_presence_of :payment_condition_id

  attr_accessor :provider_name

  before_save :get_next_number
  before_save :create_payable

  def get_next_number
    self.number ||= PurchaseOrder.number.next
  end

  def self.number
    self.find(:first, :select => "IfNull(Max(number), 0) As last, IfNull(Max(number), 0)+1 As next", :conditions => "type = 'PurchaseOrder'")
  end

  def create_payable
    if self.closed
      parcels = self.payment_form.parcels
      val = self.value / parcels.count
      parcels.each do |parc|
        rec = Payable.create({
          :client_id                => self.client_id,
          #:document_number          => self.number,
          :due_date                 => Time.new + parc.days,
          :issue_date               => Time.new,
          :value                    => val,
          :document_kind_id         => 1,
          :payment_method_id        => 1,
          :frequency_id             => 1,
          :rate_type_id             => 1,
          :rate_calculation_type_id => 1
        })
      end
    end
  end
end
