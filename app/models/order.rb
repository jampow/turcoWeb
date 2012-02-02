class Order < ActiveRecord::Base
  has_many :order_items

  accepts_nested_attributes_for :order_items , :reject_if => proc { |a| a[:product_name].blank? }

  before_save :mark_item_for_removal
  before_save :moviment_stock
  
  attr_accessor :client_name
  attr_accessor :reverse #Estorno
  
protected

  def mark_item_for_removal
    order_items.each do |child|
      child.mark_for_destruction if child.product_name.blank?
    end
  end
  
  def moviment_stock
    if self.type == "SalesOrder"
      if self.closed
        close_sales_order
      elsif self.reverse
        reverse_sales_order
      end
    elsif self.type == "PurchaseOrder"
      if self.closed
        close_purchase_order
      elsif self.reverse
        reverse_purchase_order
      end
    end
  end
  
  def close_sales_order
    order_items.each do |item|
      Stock.create :product_id      => item.product_id,
                   :description     => "Pedido de venda n. #{self.number}",
                   :measure_unit_id => item.measure_unit_id,
                   :quantity_out    => item.quantity,
                   :quantity_in     => nil
    end 
  end
  
  def reverse_sales_order
    order_items.each do |item|
      Stock.create :product_id      => item.product_id,
                   :description     => "Estorno do pedido de venda n. #{self.number}",
                   :measure_unit_id => item.measure_unit_id,
                   :quantity_out    => nil,
                   :quantity_in     => item.quantity
    end 
  end

  def close_purchase_order
    order_items.each do |item|
      Stock.create :product_id      => item.product_id,
                   :description     => "Pedido de compra n. #{self.number}",
                   :measure_unit_id => item.measure_unit_id,
                   :quantity_out    => nil,
                   :quantity_in     => item.quantity
    end 
  end
  
  def reverse_purchase_order
    order_items.each do |item|
      Stock.create :product_id      => item.product_id,
                   :description     => "Estorno do pedido de compra n. #{self.number}",
                   :measure_unit_id => item.measure_unit_id,
                   :quantity_out    => item.quantity,
                   :quantity_in     => nil
    end 
  end
  
end

