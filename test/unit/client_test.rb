require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "will be?" do
    c = Client.new client
    assert c.valid?
  end

  def client
    {
      :name => "Boa Massa",
      :nickname => "Boa",
      :doc => "04.562.324/0001-74",
      :ie => "",
      :im => "",
      :sci => "",
      :ind_com => "i",
      :active => true,
      :email_nfe => "boa@massa.com.br",
      :observations => "teste bla bla bla",
      :main_address_attributes => {
        :street => "Av. Lacerda Franco",
        :number => "404",
        :complement => "casa 4",
        :neighborhood => "Cambuci",
        :city => "São Paulo",
        :country => "Brasil",
        :cep => "01536-000",
        :estate_id => 26,
        :city_id => 3831},
      :billing_address_attributes => {
        :street => "Av. Lacerda Franco",
        :number => "404",
        :complement => "casa 4",
        :neighborhood => "Cambuci",
        :city => "São Paulo",
        :country => "Brasil",
        :cep => "01536-000",
        :estate_id => 26,
        :city_id => 3831},
      :delivery_address_attributes => {
        :street => "Av. Lacerda Franco",
        :number => "404",
        :complement => "casa 4",
        :neighborhood => "Cambuci",
        :city => "São Paulo",
        :country => "Brasil",
        :cep => "01536-000",
        :estate_id => 26,
        :city_id => 3831},
      :code => "asd.000.000.123.321"
    }
  end

end
