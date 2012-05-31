class Cst < ActiveRecord::Base
  has_many :products, :dependent => :nullify
  validates_presence_of :code
  validates_presence_of :description
end

