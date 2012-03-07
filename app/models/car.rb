class Car < ActiveRecord::Base
	belongs_to :estate
	has_many :orders

	validates_presence_of :carrier_id, :message => "Acesse novamente a partir da transportadora, se o erro perssistir, contacte o suporte."
# Select car.id
#      , cre.name As transp
#      , est.name As estate_name
#      , car.brand
#      , car.license_plate  
# From cars     car Join
#      carriers cre On cre.id = car.carrier_id Join
#      estates  est On est.id = car.estate_id
# Where car.carrier_id = 1

	named_scope :grid, lambda { |carrier_id| {
		:select     => "car.id, cre.name As transp, est.name As estate_name, car.brand, car.license_plate",
		:joins      => "car Join carriers cre On cre.id = car.carrier_id Join estates est On est.id = car.estate_id",
	  :conditions => "car.carrier_id = #{carrier_id}"
  }}
end
