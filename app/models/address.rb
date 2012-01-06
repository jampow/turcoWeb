class Address < ActiveRecord::Base
  belongs_to :estate
  has_many :bank_accounts
  has_many :clients
  has_many :providers
end

