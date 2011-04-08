require 'test_helper'

class NcmsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ncms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ncm" do
    assert_difference('Ncm.count') do
      post :create, :ncm => { }
    end

    assert_redirected_to ncm_path(assigns(:ncm))
  end

  test "should show ncm" do
    get :show, :id => ncms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => ncms(:one).to_param
    assert_response :success
  end

  test "should update ncm" do
    put :update, :id => ncms(:one).to_param, :ncm => { }
    assert_redirected_to ncm_path(assigns(:ncm))
  end

  test "should destroy ncm" do
    assert_difference('Ncm.count', -1) do
      delete :destroy, :id => ncms(:one).to_param
    end

    assert_redirected_to ncms_path
  end
end
