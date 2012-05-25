class BankAccount < ActiveRecord::Base
  has_many :transactions, :class_name => "BankAccountTransaction"
  belongs_to :address, :dependent => :destroy
  accepts_nested_attributes_for :address
  has_many :locations

  def self.to_select
    self.all.map { |v| [ v[:bank_name], v[:id] ] }
  end
end
