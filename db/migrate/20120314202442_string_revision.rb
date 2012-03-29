class StringRevision < ActiveRecord::Migration
  def self.up
  	change_column :clients, :name     , :string, :limit => 150
  	change_column :clients, :nickname , :string, :limit => 80
  	change_column :clients, :cnpj     , :string, :limit => 20 
  	change_column :clients, :ie       , :string, :limit => 20
  	change_column :clients, :im       , :string, :limit => 20
  	change_column :clients, :sci      , :string, :limit => 70
  	change_column :clients, :email_nfe, :string, :limit => 70

  	change_column :people, :name , :string, :limit => 80
  	change_column :people, :email, :string, :limit => 70

  	change_column :phones, :number, :string, :limit => 25

  	change_column :addresses, :street      , :string, :limit => 100
  	change_column :addresses, :number      , :string, :limit => 20
  	change_column :addresses, :complement  , :string, :limit => 40
  	change_column :addresses, :neighborhood, :string, :limit => 50
  	change_column :addresses, :city        , :string, :limit => 70
  	change_column :addresses, :country     , :string, :limit => 70
  	
  	change_column :estates, :acronym, :string, :limit => 2
  	change_column :estates, :name   , :string, :limit => 40

  	change_column :orders, :number, :string, :limit => 10

  	change_column :payment_forms, :name, :string, :limit => 50

  	change_column :invoices, :nfe_received_key, :string, :limit => 254
  	change_column :invoices, :nfe_key         , :string, :limit => 254
  	change_column :invoices, :nfe_protocol    , :string, :limit => 254

  	change_column :terms, :name, :string, :limit => 50

  	change_column :products, :code       , :string, :limit => 20
  	change_column :products, :name       , :string, :limit => 70
  	change_column :products, :kind       , :string, :limit => 50
  	change_column :products, :fiscal_code, :string, :limit => 50
  	change_column :products, :ncm        , :string, :limit => 20

  	change_column :measure_units, :measure_unit, :string, :limit => 40

  	change_column :csts, :code       , :string, :limit => 20
  	change_column :csts, :description, :string, :limit => 50
  end

  def self.down
  	change_column :clients, :name     , :string
  	change_column :clients, :nickname , :string
  	change_column :clients, :cnpj     , :string
  	change_column :clients, :ie       , :string
  	change_column :clients, :im       , :string
  	change_column :clients, :sci      , :string
  	change_column :clients, :email_nfe, :string

  	change_column :people, :name , :string
  	change_column :people, :email, :string

  	change_column :phones, :number, :string

  	change_column :addresses, :street      , :string
  	change_column :addresses, :number      , :string
  	change_column :addresses, :complement  , :string
  	change_column :addresses, :neighborhood, :string
  	change_column :addresses, :city        , :string
  	change_column :addresses, :country     , :string
  	
  	change_column :estates, :acronym, :string
  	change_column :estates, :name   , :string

  	change_column :orders, :number, :string

  	change_column :payment_forms, :name, :string

  	change_column :invoices, :nfe_received_key, :string
  	change_column :invoices, :nfe_key         , :string
  	change_column :invoices, :nfe_protocol    , :string

  	change_column :terms, :name, :string

  	change_column :products, :code       , :string
  	change_column :products, :name       , :string
  	change_column :products, :kind       , :string
  	change_column :products, :fiscal_code, :string
  	change_column :products, :ncm        , :string

  	change_column :measure_units, :measure_unit, :string

  	change_column :csts, :code       , :string
  	change_column :csts, :description, :string
  end
end
