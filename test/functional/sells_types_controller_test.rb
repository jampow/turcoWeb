require 'test_helper'

class SellsTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sells_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sells_type" do
    assert_difference('SellsType.count') do
      post :create, :sells_type => { }
    end

    assert_redirected_to sells_type_path(assigns(:sells_type))
  end

  test "should show sells_type" do
    get :show, :id => sells_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sells_types(:one).to_param
    assert_response :success
  end

  test "should update sells_type" do
    put :update, :id => sells_types(:one).to_param, :sells_type => { }
    assert_redirected_to sells_type_path(assigns(:sells_type))
  end

  test "should destroy sells_type" do
    assert_difference('SellsType.count', -1) do
      delete :destroy, :id => sells_types(:one).to_param
    end

    assert_redirected_to sells_types_path
  end
end
