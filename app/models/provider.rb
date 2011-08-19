class Provider < ActiveRecord::Base
  belongs_to :address                                                                  , :dependent => :destroy
  belongs_to :seller_contact  , :class_name => 'Contact', :foreign_key => 'seller_id'  , :dependent => :destroy
  belongs_to :invoicer_contact, :class_name => 'Contact', :foreign_key => 'invoicer_id', :dependent => :destroy

  accepts_nested_attributes_for :seller_contact  , :reject_if => proc { |a| a[:name].blank? }
  accepts_nested_attributes_for :invoicer_contact, :reject_if => proc { |a| a[:name].blank? }
  accepts_nested_attributes_for :address
end

