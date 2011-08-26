class AlterHollydays < ActiveRecord::Migration
  def self.up
    add_column    :hollydays,:day  ,:integer
    add_column    :hollydays,:month,:integer
    remove_column :hollydays,:date
  end

  def self.down
    remove_column :hollydays,:day
    remove_column :hollydays,:month
    add_column    :hollydays,:date ,:date
  end
end

