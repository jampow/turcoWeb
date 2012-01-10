require 'test_helper'

class BankAccountTransactionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_account_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_account_transaction" do
    assert_difference('BankAccountTransaction.count') do
      post :create, :bank_account_transaction => { }
    end

    assert_redirected_to bank_account_transaction_path(assigns(:bank_account_transaction))
  end

  test "should show bank_account_transaction" do
    get :show, :id => bank_account_transactions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bank_account_transactions(:one).to_param
    assert_response :success
  end

  test "should update bank_account_transaction" do
    put :update, :id => bank_account_transactions(:one).to_param, :bank_account_transaction => { }
    assert_redirected_to bank_account_transaction_path(assigns(:bank_account_transaction))
  end

  test "should destroy bank_account_transaction" do
    assert_difference('BankAccountTransaction.count', -1) do
      delete :destroy, :id => bank_account_transactions(:one).to_param
    end

    assert_redirected_to bank_account_transactions_path
  end
end
