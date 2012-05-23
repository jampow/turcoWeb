require 'test_helper'

class LocationReceiptsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_receipts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create location_receipt" do
    assert_difference('LocationReceipt.count') do
      post :create, :location_receipt => { }
    end

    assert_redirected_to location_receipt_path(assigns(:location_receipt))
  end

  test "should show location_receipt" do
    get :show, :id => location_receipts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => location_receipts(:one).to_param
    assert_response :success
  end

  test "should update location_receipt" do
    put :update, :id => location_receipts(:one).to_param, :location_receipt => { }
    assert_redirected_to location_receipt_path(assigns(:location_receipt))
  end

  test "should destroy location_receipt" do
    assert_difference('LocationReceipt.count', -1) do
      delete :destroy, :id => location_receipts(:one).to_param
    end

    assert_redirected_to location_receipts_path
  end
end
