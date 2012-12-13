require 'test_helper'

class DocstatusesControllerTest < ActionController::TestCase
  setup do
    @docstatus = docstatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:docstatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create docstatus" do
    assert_difference('Docstatus.count') do
      post :create, docstatus: @docstatus.attributes
    end

    assert_redirected_to docstatus_path(assigns(:docstatus))
  end

  test "should show docstatus" do
    get :show, id: @docstatus.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @docstatus.to_param
    assert_response :success
  end

  test "should update docstatus" do
    put :update, id: @docstatus.to_param, docstatus: @docstatus.attributes
    assert_redirected_to docstatus_path(assigns(:docstatus))
  end

  test "should destroy docstatus" do
    assert_difference('Docstatus.count', -1) do
      delete :destroy, id: @docstatus.to_param
    end

    assert_redirected_to docstatuses_path
  end
end
