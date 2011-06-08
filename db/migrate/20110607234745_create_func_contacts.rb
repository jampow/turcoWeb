class CreateFuncContacts < ActiveRecord::Migration
  def self.up
    execute <<-SQL
              Alter Table people
               Add Column function_id integer
                    After department_id
            SQL
  end

  def self.down
    remove_column :people, :function_id
  end
end

