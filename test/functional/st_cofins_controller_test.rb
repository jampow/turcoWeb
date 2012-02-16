require 'test_helper'

class StCofinsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:st_cofins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create st_cofin" do
    assert_difference('StCofin.count') do
      post :create, :st_cofin => { }
    end

    assert_redirected_to st_cofin_path(assigns(:st_cofin))
  end

  test "should show st_cofin" do
    get :show, :id => st_cofins(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => st_cofins(:one).to_param
    assert_response :success
  end

  test "should update st_cofin" do
    put :update, :id => st_cofins(:one).to_param, :st_cofin => { }
    assert_redirected_to st_cofin_path(assigns(:st_cofin))
  end

  test "should destroy st_cofin" do
    assert_difference('StCofin.count', -1) do
      delete :destroy, :id => st_cofins(:one).to_param
    end

    assert_redirected_to st_cofins_path
  end
end
