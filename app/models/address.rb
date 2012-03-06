class Address < ActiveRecord::Base
  belongs_to :estate
  has_many :bank_accounts
  has_many :clients
  has_many :providers
  has_one  :client

  validate :cityInEstate

  def cityInEstate
  	if self.estate_id != 0 && self.city_id != 0
	    estate = Estate.find(self.estate_id)
	    city   = City.find(self.city_id)
	    self.errors.add("city", " não pertencente ao estado") unless estate.acronym == city.estate_acronym
  	end
  end
end

