class Seller < ActiveRecord::Base
  belongs_to :address
  accepts_nested_attributes_for :address
  has_many :seller_credit_accounts
  has_many :invoices
end
