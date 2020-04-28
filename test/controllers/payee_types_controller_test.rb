require 'test_helper'

class PayeeTypesControllerTest < ActionController::TestCase
  setup do
    @payee_type = payee_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payee_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payee_type" do
    assert_difference('PayeeType.count') do
      post :create, payee_type: { name: @payee_type.name }
    end

    assert_redirected_to payee_type_path(assigns(:payee_type))
  end

  test "should show payee_type" do
    get :show, id: @payee_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payee_type
    assert_response :success
  end

  test "should update payee_type" do
    patch :update, id: @payee_type, payee_type: { name: @payee_type.name }
    assert_redirected_to payee_type_path(assigns(:payee_type))
  end

  test "should destroy payee_type" do
    assert_difference('PayeeType.count', -1) do
      delete :destroy, id: @payee_type
    end

    assert_redirected_to payee_types_path
  end
end
