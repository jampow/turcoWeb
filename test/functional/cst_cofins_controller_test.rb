require 'test_helper'

class CstCofinsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cst_cofins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cst_cofin" do
    assert_difference('CstCofin.count') do
      post :create, :cst_cofin => { }
    end

    assert_redirected_to cst_cofin_path(assigns(:cst_cofin))
  end

  test "should show cst_cofin" do
    get :show, :id => cst_cofins(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => cst_cofins(:one).to_param
    assert_response :success
  end

  test "should update cst_cofin" do
    put :update, :id => cst_cofins(:one).to_param, :cst_cofin => { }
    assert_redirected_to cst_cofin_path(assigns(:cst_cofin))
  end

  test "should destroy cst_cofin" do
    assert_difference('CstCofin.count', -1) do
      delete :destroy, :id => cst_cofins(:one).to_param
    end

    assert_redirected_to cst_cofins_path
  end
end
