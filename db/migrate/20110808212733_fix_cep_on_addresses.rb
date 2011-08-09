class FixCepOnAddresses < ActiveRecord::Migration
  def self.up
    execute <<-SQL
              Alter Table addresses
                Modify Column cep varchar(9)
            SQL
  end

  def self.down
    execute <<-SQL
              Alter Table addresses
                Modify Column cep int
            SQL
  end
end

