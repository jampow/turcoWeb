require 'test_helper'

class CstIcmsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cst_icms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cst_icm" do
    assert_difference('CstIcm.count') do
      post :create, :cst_icm => { }
    end

    assert_redirected_to cst_icm_path(assigns(:cst_icm))
  end

  test "should show cst_icm" do
    get :show, :id => cst_icms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cst_icms(:one).to_param
    assert_response :success
  end

  test "should update cst_icm" do
    put :update, :id => cst_icms(:one).to_param, :cst_icm => { }
    assert_redirected_to cst_icm_path(assigns(:cst_icm))
  end

  test "should destroy cst_icm" do
    assert_difference('CstIcm.count', -1) do
      delete :destroy, :id => cst_icms(:one).to_param
    end

    assert_redirected_to cst_icms_path
  end
end
