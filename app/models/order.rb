class Order < ActiveRecord::Base
  has_many   :order_items

  accepts_nested_attributes_for :order_items , :reject_if => proc { |a| a[:product_name].blank? }

  before_save :mark_item_for_removal

  def mark_item_for_removal
    order_items.each do |child|
      child.mark_for_destruction if child.product_name.blank?
    end
  end
end

