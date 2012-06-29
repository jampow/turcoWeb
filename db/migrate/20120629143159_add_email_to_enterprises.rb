class AddEmailToEnterprises < ActiveRecord::Migration
  def self.up
    add_column :enterprises, :email, :string
  end

  def self.down
    remove_column :enterprises, :email
  end
end
