require 'test_helper'

class DepartsControllerTest < ActionController::TestCase
  setup do
    @depart = departs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:departs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create depart" do
    assert_difference('Depart.count') do
      post :create, depart: @depart.attributes
    end

    assert_redirected_to depart_path(assigns(:depart))
  end

  test "should show depart" do
    get :show, id: @depart.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @depart.to_param
    assert_response :success
  end

  test "should update depart" do
    put :update, id: @depart.to_param, depart: @depart.attributes
    assert_redirected_to depart_path(assigns(:depart))
  end

  test "should destroy depart" do
    assert_difference('Depart.count', -1) do
      delete :destroy, id: @depart.to_param
    end

    assert_redirected_to departs_path
  end
end
