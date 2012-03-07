class PaymentForm < ActiveRecord::Base
	has_many :orders
end
