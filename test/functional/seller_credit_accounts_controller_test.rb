require 'test_helper'

class SellerCreditAccountsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:seller_credit_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create seller_credit_account" do
    assert_difference('SellerCreditAccount.count') do
      post :create, :seller_credit_account => { }
    end

    assert_redirected_to seller_credit_account_path(assigns(:seller_credit_account))
  end

  test "should show seller_credit_account" do
    get :show, :id => seller_credit_accounts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => seller_credit_accounts(:one).to_param
    assert_response :success
  end

  test "should update seller_credit_account" do
    put :update, :id => seller_credit_accounts(:one).to_param, :seller_credit_account => { }
    assert_redirected_to seller_credit_account_path(assigns(:seller_credit_account))
  end

  test "should destroy seller_credit_account" do
    assert_difference('SellerCreditAccount.count', -1) do
      delete :destroy, :id => seller_credit_accounts(:one).to_param
    end

    assert_redirected_to seller_credit_accounts_path
  end
end
