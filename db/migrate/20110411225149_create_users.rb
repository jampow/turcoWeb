class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name

      # Authlogic
      t.string   :login
      t.string   :email
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :persistence_token

      # Authlogic Magic Fields
      t.integer  :login_count
      t.integer  :failed_login_count
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string   :current_login_ip
      t.string   :last_login_ip

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

