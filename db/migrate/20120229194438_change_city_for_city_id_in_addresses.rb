class ChangeCityForCityIdInAddresses < ActiveRecord::Migration
  def self.up
    add_column :addresses, :city_id, :integer
    
    execute <<-SQL
              Update addresses
              Set estate_id = 26
              Where city = 'SAO PAULO' 
            SQL
            
    execute <<-SQL
              Update addresses addr Join
                     estates   est  On est.id             = addr.estate_id Join
                     cities    cit  On cit.name           = addr.city 
                                   And cit.estate_acronym = est.acronym
              Set addr.city_id = cit.id
              Where addr.city_id is null
            SQL
  end

  def self.down
    remove_column :addresses, :city_id
  end
end
