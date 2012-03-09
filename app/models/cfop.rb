class Cfop < ActiveRecord::Base
  validates_presence_of :number, :name
  validates_length_of :name, :maximum => 40
  validates_numericality_of :number, :greater_than_or_equal_to => 1100, :less_than => 8000

  has_many :invoices
end
