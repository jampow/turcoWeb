class BankAccount < ActiveRecord::Base
  belongs_to :address, :dependent => :destroy
  accepts_nested_attributes_for :address
end
