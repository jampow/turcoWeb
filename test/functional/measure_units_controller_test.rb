require 'test_helper'

class MeasureUnitsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:measure_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create measure_unit" do
    assert_difference('MeasureUnit.count') do
      post :create, :measure_unit => { }
    end

    assert_redirected_to measure_unit_path(assigns(:measure_unit))
  end

  test "should show measure_unit" do
    get :show, :id => measure_units(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => measure_units(:one).to_param
    assert_response :success
  end

  test "should update measure_unit" do
    put :update, :id => measure_units(:one).to_param, :measure_unit => { }
    assert_redirected_to measure_unit_path(assigns(:measure_unit))
  end

  test "should destroy measure_unit" do
    assert_difference('MeasureUnit.count', -1) do
      delete :destroy, :id => measure_units(:one).to_param
    end

    assert_redirected_to measure_units_path
  end
end
