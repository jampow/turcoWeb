class Client < ActiveRecord::Base
  has_many :addresses, :as => :addressable, :dependent => :destroy
  belongs_to :main_address,     :class_name => 'Address', :foreign_key => 'main_address_id'     , :dependent => :destroy
  belongs_to :billing_address,  :class_name => 'Address', :foreign_key => 'billing_address_id'  , :dependent => :destroy
  belongs_to :delivery_address, :class_name => 'Address', :foreign_key => 'delivery_address_id' , :dependent => :destroy

  accepts_nested_attributes_for :main_address
  accepts_nested_attributes_for :billing_address
  accepts_nested_attributes_for :delivery_address
end

