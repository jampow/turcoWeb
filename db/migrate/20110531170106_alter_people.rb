class AlterPeople < ActiveRecord::Migration
  def self.up
    rename_column :people, :client_id, :external_id

    execute <<-SQL
              ALTER TABLE people
               ADD COLUMN type varchar(255)
                    AFTER external_id
            SQL

    execute "UPDATE people SET type = 'Contact'"
  end

  def self.down
    rename_column :people, :external_id, :client_id
    remove_column :people, :external_id
  end
end

