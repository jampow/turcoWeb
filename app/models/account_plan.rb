class AccountPlan < ActiveRecord::Base
  def self.to_select
    self.all.map { |v| [ v[:name], v[:id] ] }
  end
end
