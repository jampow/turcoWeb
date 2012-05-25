class LocationReceiptItem < ActiveRecord::Base
  belongs_to :receipt, :class_name => "LocationReceipt"
end
