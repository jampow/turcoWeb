class SalesOrder < ActiveRecord::Base
  belongs_to :client
  has_many   :sales_order_items

  accepts_nested_attributes_for :sales_order_items #, :reject_if => proc { |a| a[:name].blank? }
end

