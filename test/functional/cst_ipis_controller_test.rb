require 'test_helper'

class CstIpisControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cst_ipis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cst_ipi" do
    assert_difference('CstIpi.count') do
      post :create, :cst_ipi => { }
    end

    assert_redirected_to cst_ipi_path(assigns(:cst_ipi))
  end

  test "should show cst_ipi" do
    get :show, :id => cst_ipis(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cst_ipis(:one).to_param
    assert_response :success
  end

  test "should update cst_ipi" do
    put :update, :id => cst_ipis(:one).to_param, :cst_ipi => { }
    assert_redirected_to cst_ipi_path(assigns(:cst_ipi))
  end

  test "should destroy cst_ipi" do
    assert_difference('CstIpi.count', -1) do
      delete :destroy, :id => cst_ipis(:one).to_param
    end

    assert_redirected_to cst_ipis_path
  end
end
