require 'test_helper'

class StPisControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:st_pis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create st_pi" do
    assert_difference('StPi.count') do
      post :create, :st_pi => { }
    end

    assert_redirected_to st_pi_path(assigns(:st_pi))
  end

  test "should show st_pi" do
    get :show, :id => st_pis(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => st_pis(:one).to_param
    assert_response :success
  end

  test "should update st_pi" do
    put :update, :id => st_pis(:one).to_param, :st_pi => { }
    assert_redirected_to st_pi_path(assigns(:st_pi))
  end

  test "should destroy st_pi" do
    assert_difference('StPi.count', -1) do
      delete :destroy, :id => st_pis(:one).to_param
    end

    assert_redirected_to st_pis_path
  end
end
