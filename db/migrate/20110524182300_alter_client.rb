class AlterClient < ActiveRecord::Migration
  def self.up
    add_column    :clients, :activity_id, :integer
    remove_column :clients, :activity
  end

  def self.down
    remove_column :clients, :activity_id
    add_column    :clients, :activity   , :string
  end
end

