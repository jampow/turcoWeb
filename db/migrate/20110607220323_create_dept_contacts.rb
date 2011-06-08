class CreateDeptContacts < ActiveRecord::Migration
  def self.up
    execute <<-SQL
              Alter Table departments
               Add Column type varchar(255)
                    After name
            SQL

    execute <<-SQL
              Alter Table people
               Add Column department_id integer
                    After type
            SQL
  end

  def self.down
    remove_column :departments, :type
    remove_column :people     , :department_id
  end
end

