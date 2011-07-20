class Person < ActiveRecord::Base
  has_many :phones, :dependent => :destroy

  accepts_nested_attributes_for :phones, :reject_if => proc { |a| a[:number].blank? }
end

