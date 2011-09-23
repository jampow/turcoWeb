require 'test_helper'

class CstPisControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cst_pis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cst_pi" do
    assert_difference('CstPi.count') do
      post :create, :cst_pi => { }
    end

    assert_redirected_to cst_pi_path(assigns(:cst_pi))
  end

  test "should show cst_pi" do
    get :show, :id => cst_pis(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cst_pis(:one).to_param
    assert_response :success
  end

  test "should update cst_pi" do
    put :update, :id => cst_pis(:one).to_param, :cst_pi => { }
    assert_redirected_to cst_pi_path(assigns(:cst_pi))
  end

  test "should destroy cst_pi" do
    assert_difference('CstPi.count', -1) do
      delete :destroy, :id => cst_pis(:one).to_param
    end

    assert_redirected_to cst_pis_path
  end
end
