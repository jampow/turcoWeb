require 'test_helper'

class DeptContactsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dept_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dept_contact" do
    assert_difference('DeptContact.count') do
      post :create, :dept_contact => { }
    end

    assert_redirected_to dept_contact_path(assigns(:dept_contact))
  end

  test "should show dept_contact" do
    get :show, :id => dept_contacts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => dept_contacts(:one).to_param
    assert_response :success
  end

  test "should update dept_contact" do
    put :update, :id => dept_contacts(:one).to_param, :dept_contact => { }
    assert_redirected_to dept_contact_path(assigns(:dept_contact))
  end

  test "should destroy dept_contact" do
    assert_difference('DeptContact.count', -1) do
      delete :destroy, :id => dept_contacts(:one).to_param
    end

    assert_redirected_to dept_contacts_path
  end
end
