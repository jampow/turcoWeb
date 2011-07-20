class AddEmailToPeople < ActiveRecord::Migration
  def self.up
    execute <<-SQL
              Alter Table people
                Add Column email varchar(255) After department_id
            SQL
  end

  def self.down
    remove_column :people, :email
  end
end

