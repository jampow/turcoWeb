class BankAccount < ActiveRecord::Base
  has_many :transactions, :class_name => "BankAccountTransaction"
  belongs_to :address, :dependent => :destroy
  accepts_nested_attributes_for :address
end
