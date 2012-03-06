class Carrier < ActiveRecord::Base
	validates_length_of :name    , :maximum => 70
	validates_length_of :nickname, :maximum => 50
	validates_length_of :cnpj    , :maximum => 18
	validates_length_of :ie      , :maximum => 15

	belongs_to :address
  accepts_nested_attributes_for :address
end
