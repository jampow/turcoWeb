class AccountPlan < ActiveRecord::Base
  validates_presence_of :name
  
  def self.to_select
    self.all.map { |v| [ v[:name], v[:id] ] }
  end
end
