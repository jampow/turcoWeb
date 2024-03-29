class SalesOrder < Order
  belongs_to :client
  belongs_to :seller

  validates_presence_of :client_id
  validates_uniqueness_of :number

  attr_accessor :seller_name

# Select IfNull(       Max(number), 0)          As last
#      , Concat(IfNull(Max(number), 0)+1, "-A") As next
# From orders
# Where type = 'SalesOrder'

  def self.number
    self.find(:first, :select => "IfNull(Max(number), 0) As last, Concat(IfNull(Max(number), 0)+1, '-A') As next", :conditions => "type = 'SalesOrder'")
  end

  before_save :get_next_number
  before_save :verify_pend
  before_save :create_invoice
  before_save :create_receivable

  def get_next_number
    self.number ||= SalesOrder.number.next
  end

  def verify_pend
    if self.closed
      itens_pend = []
      self.order_items.each do |item|
        if item.quantity_produced < item.quantity && item.pend
          new_item = item.attributes

          new_item['quantity']         -= item.quantity_produced
          new_item['quantity_produced'] = 0
          new_item['pend']              = false

          item.total_value         = item.quantity_produced * item.unit_value
          new_item['total_value'] -= item.total_value

          itens_pend << new_item
        end
      end

      unless itens_pend.blank?
        ped_pend = SalesOrder.new(self.attributes)
        ped_pend.closed = false
        ped_pend.number = self.number.next
        ped_pend.order_items.build itens_pend
        ped_pend.save
      end
    end
  end

  def create_invoice
    if self.closed
      inv                 = Invoice.new
      inv.order_id        = self.id
      inv.operation       = Date.today
      inv.invoice_number  = Invoice.number[0].next
      inv.client_id       = self.client_id
      inv.seller_id       = self.seller_id
      inv.commission_rate = self.commission
      inv.activity_id     = self.client.activity_id
      inv.sell_id         = 1
      #inv.natop_id #verificar
      inv.car_id          = self.car_id
      inv.freight         = self.freight

      self.order_items.each do |item|
        #logger.info item
        inv_i = inv.itens.build
        inv_i.product_id      = item.product_id
        inv_i.product_cod     = item.product.code
        inv_i.product_name    = item.product.name
        inv_i.quantity        = item.quantity_produced
        inv_i.measure_unit_id = item.measure_unit_id
        inv_i.unit_value      = item.unit_value
        inv_i.total_value     = item.total_value
        inv_i.ipi             = item.product.ipi
        inv_i.net_weight      = item.net_weight
        inv_i.gross_weight    = item.gross_weight
      end
      inv.save
    end
  end

  #TODO: Passar esse método pro model Invoice, quando já estiver funcionando o envio
  def create_receivable
    if self.closed
      parcels = self.payment_form.parcels
      val = self.value / parcels.count
      parcels.each do |parc|
        rec = Receivable.create({
          :client_id                => self.client_id,
          #:document_number          => self.number,
          :due_date                 => Time.new + parc.days,
          :issue_date               => Time.new,
          :value                    => val,
          :document_kind_id         => 1,
          :payment_method_id        => 1,
          :frequency_id             => 1,
          :rate_type_id             => 1,
          :rate_calculation_type_id => 1,
          :settled                  => 0
        })
      end
    end
  end

  def has_production?
    sum = 0
    soi = OrderItem.find(:all, :select => 'quantity_produced, product_id , measure_unit_id' , :conditions => ['order_id = ?', self.id])
    soi.each do |i|
      sum += i.quantity_produced
    end
    return sum > 0 ? true : false
  end

  class OrderType <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Venda'},
      {:id => 2, :name => 'Cotação'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end

  class SellType <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'Produtos'},
      {:id => 2, :name => 'Serviços'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end

  class Freight <
    Struct.new(:id, :name)
    VALUES = [
      {:id => 1, :name => 'CIF'},
      {:id => 2, :name => 'FOB'}
    ]
    def self.all
      VALUES.map { |v| self.new(v[:id], v[:name]) }
    end

    def self.to_select
      VALUES.map { |v| [v[:name], v[:id]] }
    end

    def self.find(id)
      h=VALUES.find { |v| v[:id] == id }
      return nil if h.nil?
      self.new(h[:id], h[:name])
    end
  end

# Select orders.id
#      , orders.number
#      , orders.order_type_id
#      , orders.sale_type_id
#      , orders.date
#      , orders.prevision
#      , orders.billed
#      , cli.name As cli
#      , sel.name As sel
#      , orders.commission
#      , orders.contact
#      , pac.name As payment
#      , orders.freight
#      , orders.freight_type_id
#      , usr.name As attendant
#      , orders.observation
#      , orders.created_at
#      , orders.updated_at
#      , orders.closed
#      , concat(crr.name, ' - ', car.license_plate) As car_plate
# From orders
# Left Join clients       cli On cli.id = orders.client_id
# Left Join sellers       sel On sel.id = orders.seller_id
# Left Join payment_forms pac On pac.id = orders.payment_condition_id
# Left Join cars          car On car.id = orders.car_id
# Left Join carriers      crr On crr.id = car.carrier_id
# Left Join users         usr On usr.id = orders.attendant_id
# Where type = 'SalesOrder'

  named_scope :show, lambda { |id| {
    :select     => "orders.id, orders.number, orders.order_type_id, orders.sale_type_id, orders.date, orders.prevision, orders.billed, cli.name As cli, sel.name As sel, orders.commission, orders.contact, pac.name As payment, orders.freight, orders.freight_type_id, usr.name As attendant, orders.observation, orders.created_at, orders.updated_at, orders.closed, concat(crr.name, ' - ', car.license_plate) As car_plate",
    :joins      => "Left Join clients cli On cli.id = orders.client_id Left Join sellers sel On sel.id = orders.seller_id Left Join payment_forms pac On pac.id = orders.payment_condition_id Left Join cars car On car.id = orders.car_id Left Join carriers crr On crr.id = car.carrier_id Left Join users usr On usr.id = orders.attendant_id",
    :conditions => ["orders.id = ?", id]
    }
  }

end

