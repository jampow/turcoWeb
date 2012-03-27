class Address < ActiveRecord::Base
  belongs_to :estate
  has_many :bank_accounts
  has_many :clients
  has_many :providers
  has_one  :client

  validate :cityInEstate

  def cityInEstate
    if self.has_attribute?(:city_id) && self.has_attribute?(:estate_id)
    	unless self.estate_id == 0 || self.city_id == 0 || self.estate_id.nil? || self.city_id.nil?
  	    estate = Estate.find(self.estate_id)
  	    city   = City.find(self.city_id)
  	    self.errors.add("city", " não pertencente ao estado") unless estate.acronym == city.estate_acronym
    	end
    end
  end
end

