class SalesOrder < Order
  belongs_to :client

  validates_presence_of :client_id
  validates_uniqueness_of :number

  before_save :get_next_number

  def get_next_number
    self.number ||= SalesOrder.number.next
  end

# Select IfNull(       Max(number), 0)          As last
#      , Concat(IfNull(Max(number), 0)+1, "-A") As next
# From orders
# Where type = 'SalesOrder'

  def self.number
    self.find(:first, :select => "IfNull(Max(number), 0) As last, Concat(IfNull(Max(number), 0)+1, '-A') As next", :conditions => "type = 'SalesOrder'")
  end

  before_save :verify_pend
  before_save :create_invoice

  def verify_pend
    if self.closed
      itens_pend = []
      self.order_items.each do |item|
        if item.quantity_produced < item.quantity && item.pend
          new_item = item.attributes

          new_item['quantity']         -= new_item['quantity_produced']
          new_item['quantity_produced'] = 0
          new_item['pend']              = false

          item.total_value         = (item.quantity_produced * item.total_value) / item.quantity
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

end

