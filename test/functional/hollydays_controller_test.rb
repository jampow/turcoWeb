require 'test_helper'

class HollydaysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hollydays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hollyday" do
    assert_difference('Hollyday.count') do
      post :create, :hollyday => { }
    end

    assert_redirected_to hollyday_path(assigns(:hollyday))
  end

  test "should show hollyday" do
    get :show, :id => hollydays(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => hollydays(:one).to_param
    assert_response :success
  end

  test "should update hollyday" do
    put :update, :id => hollydays(:one).to_param, :hollyday => { }
    assert_redirected_to hollyday_path(assigns(:hollyday))
  end

  test "should destroy hollyday" do
    assert_difference('Hollyday.count', -1) do
      delete :destroy, :id => hollydays(:one).to_param
    end

    assert_redirected_to hollydays_path
  end
end
