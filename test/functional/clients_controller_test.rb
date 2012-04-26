require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, :client => CLIENT
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, :id => clients(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => clients(:one).to_param
    assert_response :success
  end

  test "should update client" do
    put :update, :id => clients(:one).to_param, :client => { }
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, :id => clients(:one).to_param
    end

    assert_redirected_to clients_path
  end

  CLIENT = {
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
