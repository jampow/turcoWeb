class SellsType < ActiveRecord::Base
  has_many :invoices
  validates_presence_of :name
end
