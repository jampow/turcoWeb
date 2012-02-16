require 'test_helper'

class StIpisControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:st_ipis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create st_ipi" do
    assert_difference('StIpi.count') do
      post :create, :st_ipi => { }
    end

    assert_redirected_to st_ipi_path(assigns(:st_ipi))
  end

  test "should show st_ipi" do
    get :show, :id => st_ipis(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => st_ipis(:one).to_param
    assert_response :success
  end

  test "should update st_ipi" do
    put :update, :id => st_ipis(:one).to_param, :st_ipi => { }
    assert_redirected_to st_ipi_path(assigns(:st_ipi))
  end

  test "should destroy st_ipi" do
    assert_difference('StIpi.count', -1) do
      delete :destroy, :id => st_ipis(:one).to_param
    end

    assert_redirected_to st_ipis_path
  end
end
