require 'test_helper'

class CarriersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carriers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create carrier" do
    assert_difference('Carrier.count') do
      post :create, :carrier => { }
    end

    assert_redirected_to carrier_path(assigns(:carrier))
  end

  test "should show carrier" do
    get :show, :id => carriers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => carriers(:one).to_param
    assert_response :success
  end

  test "should update carrier" do
    put :update, :id => carriers(:one).to_param, :carrier => { }
    assert_redirected_to carrier_path(assigns(:carrier))
  end

  test "should destroy carrier" do
    assert_difference('Carrier.count', -1) do
      delete :destroy, :id => carriers(:one).to_param
    end

    assert_redirected_to carriers_path
  end
end
