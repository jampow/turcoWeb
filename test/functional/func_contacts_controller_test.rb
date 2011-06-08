require 'test_helper'

class FuncContactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:func_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create func_contact" do
    assert_difference('FuncContact.count') do
      post :create, :func_contact => { }
    end

    assert_redirected_to func_contact_path(assigns(:func_contact))
  end

  test "should show func_contact" do
    get :show, :id => func_contacts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => func_contacts(:one).to_param
    assert_response :success
  end

  test "should update func_contact" do
    put :update, :id => func_contacts(:one).to_param, :func_contact => { }
    assert_redirected_to func_contact_path(assigns(:func_contact))
  end

  test "should destroy func_contact" do
    assert_difference('FuncContact.count', -1) do
      delete :destroy, :id => func_contacts(:one).to_param
    end

    assert_redirected_to func_contacts_path
  end
end
