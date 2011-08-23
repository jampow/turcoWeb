class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.integer :external_id
      t.string  :table_rel
      t.string  :description
      t.integer :level
      t.string  :filename
      t.string  :content_type
      t.binary  :data

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end

