require 'test_helper'

class PayeesControllerTest < ActionController::TestCase
  setup do
    @payee = payees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payee" do
    assert_difference('Payee.count') do
      post :create, payee: { account_number: @payee.account_number, address: @payee.address, city: @payee.city, contact: @payee.contact, name: @payee.name, note: @payee.note, state: @payee.state, website: @payee.website, zip: @payee.zip }
    end

    assert_redirected_to payee_path(assigns(:payee))
  end

  test "should show payee" do
    get :show, id: @payee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payee
    assert_response :success
  end

  test "should update payee" do
    patch :update, id: @payee, payee: { account_number: @payee.account_number, address: @payee.address, city: @payee.city, contact: @payee.contact, name: @payee.name, note: @payee.note, state: @payee.state, website: @payee.website, zip: @payee.zip }
    assert_redirected_to payee_path(assigns(:payee))
  end

  test "should destroy payee" do
    assert_difference('Payee.count', -1) do
      delete :destroy, id: @payee
    end

    assert_redirected_to payees_path
  end
end
