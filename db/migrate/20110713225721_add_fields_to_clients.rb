class AddFieldsToClients < ActiveRecord::Migration
  def self.up
    execute <<-SQL
              Alter Table clients
                Modify Column updated_at   datetime     After old_id,
                Modify Column created_at   datetime     After old_id,
                Modify Column observations text         After active,
                Modify Column im           varchar(255) After ie,
                Modify Column activity_id  int(11)      After im,
                Add    Column sci          varchar(255) After im,
                Add    Column ind_com      varchar(1)   After activity_id,
                Add    Column email_nfe    varchar(255) After active
            SQL
  end

  def self.down
    remove_column :clients, :sci
    remove_column :clients, :ind_com
    remove_column :clients, :email_nfe
    change_column :clients, :observations, :string
  end
end

