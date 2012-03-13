class SalesOrder < Order
  belongs_to :client

  validates_presence_of :client_id
  validates_uniqueness_of :number

  before_save :get_next_number

  def get_next_number
    self.number ||= SalesOrder.number.next
  end

  def self.number
    self.find(:first, :select => "IfNull(Max(number), 0) As last, IfNull(Max(number), 0)+1 As next", :conditions => "type = 'SalesOrder'")
  end

  before_save :create_invoice

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
        inv_i.quantity        = item.quantity
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

