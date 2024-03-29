class AddingPhotoToContact < ActiveRecord::Migration
  def self.up
    change_table :people do |t|
      t.has_attached_file :photo
    end
  end

  def self.down
    drop_attached_file :people, :photo
  end
end
