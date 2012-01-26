require 'test_helper'

class ReceivableBillingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:receivable_billings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create receivable_billing" do
    assert_difference('ReceivableBilling.count') do
      post :create, :receivable_billing => { }
    end

    assert_redirected_to receivable_billing_path(assigns(:receivable_billing))
  end

  test "should show receivable_billing" do
    get :show, :id => receivable_billings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => receivable_billings(:one).to_param
    assert_response :success
  end

  test "should update receivable_billing" do
    put :update, :id => receivable_billings(:one).to_param, :receivable_billing => { }
    assert_redirected_to receivable_billing_path(assigns(:receivable_billing))
  end

  test "should destroy receivable_billing" do
    assert_difference('ReceivableBilling.count', -1) do
      delete :destroy, :id => receivable_billings(:one).to_param
    end

    assert_redirected_to receivable_billings_path
  end
end
