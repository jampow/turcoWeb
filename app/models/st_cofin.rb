class StCofin < ActiveRecord::Base
  validates_presence_of :name, :aliquot
end
