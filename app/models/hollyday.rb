class Hollyday < ActiveRecord::Base
  validates_presence_of :day,:month
end

