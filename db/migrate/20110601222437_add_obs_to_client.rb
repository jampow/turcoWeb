class AddObsToClient < ActiveRecord::Migration
  def self.up
    remove_column :clients, :sci
    add_column    :clients, :observations , :string , :after => 'cep'
    add_column    :clients, :im           , :string , :after => 'ie'
    add_column    :clients, :old_id       , :integer, :after => 'im'
  end

  def self.down
    add_column    :clients, :sci          , :string, :after => 'cep'
    remove_column :clients, :observations
    remove_column :clients, :im
    remove_column :clients, :old_id
  end
end

