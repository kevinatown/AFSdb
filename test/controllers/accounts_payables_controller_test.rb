require 'test_helper'

class AccountsPayablesControllerTest < ActionController::TestCase
  setup do
    @accounts_payable = accounts_payables(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts_payables)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accounts_payable" do
    assert_difference('AccountsPayable.count') do
      post :create, accounts_payable: { ammount: @accounts_payable.ammount, ammount_paid: @accounts_payable.ammount_paid, billing_end: @accounts_payable.billing_end, billing_start: @accounts_payable.billing_start, date_paid: @accounts_payable.date_paid, datedue: @accounts_payable.datedue, pp_ammount: @accounts_payable.pp_ammount, pp_date: @accounts_payable.pp_date }
    end

    assert_redirected_to accounts_payable_path(assigns(:accounts_payable))
  end

  test "should show accounts_payable" do
    get :show, id: @accounts_payable
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accounts_payable
    assert_response :success
  end

  test "should update accounts_payable" do
    patch :update, id: @accounts_payable, accounts_payable: { ammount: @accounts_payable.ammount, ammount_paid: @accounts_payable.ammount_paid, billing_end: @accounts_payable.billing_end, billing_start: @accounts_payable.billing_start, date_paid: @accounts_payable.date_paid, datedue: @accounts_payable.datedue, pp_ammount: @accounts_payable.pp_ammount, pp_date: @accounts_payable.pp_date }
    assert_redirected_to accounts_payable_path(assigns(:accounts_payable))
  end

  test "should destroy accounts_payable" do
    assert_difference('AccountsPayable.count', -1) do
      delete :destroy, id: @accounts_payable
    end

    assert_redirected_to accounts_payables_path
  end
end
