class SalesOrder < ActiveRecord::Base
  belongs_to :client
  has_many   :sales_order_items

  accepts_nested_attributes_for :sales_order_items , :reject_if => proc { |a| a[:product_name].blank? }

  before_save :mark_contact_for_removal

  def mark_item_for_removal
    sales_order_items.each do |child|
      child.mark_for_destruction if child.product_name.blank?
    end
  end
end

