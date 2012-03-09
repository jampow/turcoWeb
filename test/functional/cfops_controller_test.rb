require 'test_helper'

class CfopsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cfops)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cfop" do
    assert_difference('Cfop.count') do
      post :create, :cfop => { }
    end

    assert_redirected_to cfop_path(assigns(:cfop))
  end

  test "should show cfop" do
    get :show, :id => cfops(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cfops(:one).to_param
    assert_response :success
  end

  test "should update cfop" do
    put :update, :id => cfops(:one).to_param, :cfop => { }
    assert_redirected_to cfop_path(assigns(:cfop))
  end

  test "should destroy cfop" do
    assert_difference('Cfop.count', -1) do
      delete :destroy, :id => cfops(:one).to_param
    end

    assert_redirected_to cfops_path
  end
end
