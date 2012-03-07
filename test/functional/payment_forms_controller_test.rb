require 'test_helper'

class PaymentFormsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_form" do
    assert_difference('PaymentForm.count') do
      post :create, :payment_form => { }
    end

    assert_redirected_to payment_form_path(assigns(:payment_form))
  end

  test "should show payment_form" do
    get :show, :id => payment_forms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => payment_forms(:one).to_param
    assert_response :success
  end

  test "should update payment_form" do
    put :update, :id => payment_forms(:one).to_param, :payment_form => { }
    assert_redirected_to payment_form_path(assigns(:payment_form))
  end

  test "should destroy payment_form" do
    assert_difference('PaymentForm.count', -1) do
      delete :destroy, :id => payment_forms(:one).to_param
    end

    assert_redirected_to payment_forms_path
  end
end
