require 'test_helper'

class ProductFamiliesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_families)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_family" do
    assert_difference('ProductFamily.count') do
      post :create, :product_family => { }
    end

    assert_redirected_to product_family_path(assigns(:product_family))
  end

  test "should show product_family" do
    get :show, :id => product_families(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => product_families(:one).to_param
    assert_response :success
  end

  test "should update product_family" do
    put :update, :id => product_families(:one).to_param, :product_family => { }
    assert_redirected_to product_family_path(assigns(:product_family))
  end

  test "should destroy product_family" do
    assert_difference('ProductFamily.count', -1) do
      delete :destroy, :id => product_families(:one).to_param
    end

    assert_redirected_to product_families_path
  end
end
