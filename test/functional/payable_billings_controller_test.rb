require 'test_helper'

class PayableBillingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payable_billings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payable_billing" do
    assert_difference('PayableBilling.count') do
      post :create, :payable_billing => { }
    end

    assert_redirected_to payable_billing_path(assigns(:payable_billing))
  end

  test "should show payable_billing" do
    get :show, :id => payable_billings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => payable_billings(:one).to_param
    assert_response :success
  end

  test "should update payable_billing" do
    put :update, :id => payable_billings(:one).to_param, :payable_billing => { }
    assert_redirected_to payable_billing_path(assigns(:payable_billing))
  end

  test "should destroy payable_billing" do
    assert_difference('PayableBilling.count', -1) do
      delete :destroy, :id => payable_billings(:one).to_param
    end

    assert_redirected_to payable_billings_path
  end
end
