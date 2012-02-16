require 'test_helper'

class StIcmsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:st_icms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create st_icm" do
    assert_difference('StIcm.count') do
      post :create, :st_icm => { }
    end

    assert_redirected_to st_icm_path(assigns(:st_icm))
  end

  test "should show st_icm" do
    get :show, :id => st_icms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => st_icms(:one).to_param
    assert_response :success
  end

  test "should update st_icm" do
    put :update, :id => st_icms(:one).to_param, :st_icm => { }
    assert_redirected_to st_icm_path(assigns(:st_icm))
  end

  test "should destroy st_icm" do
    assert_difference('StIcm.count', -1) do
      delete :destroy, :id => st_icms(:one).to_param
    end

    assert_redirected_to st_icms_path
  end
end
