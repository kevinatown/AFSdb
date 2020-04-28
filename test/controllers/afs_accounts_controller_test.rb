require 'test_helper'

class AfsAccountsControllerTest < ActionController::TestCase
  setup do
    @afs_account = afs_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:afs_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create afs_account" do
    assert_difference('AfsAccount.count') do
      post :create, afs_account: { name: @afs_account.name }
    end

    assert_redirected_to afs_account_path(assigns(:afs_account))
  end

  test "should show afs_account" do
    get :show, id: @afs_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @afs_account
    assert_response :success
  end

  test "should update afs_account" do
    patch :update, id: @afs_account, afs_account: { name: @afs_account.name }
    assert_redirected_to afs_account_path(assigns(:afs_account))
  end

  test "should destroy afs_account" do
    assert_difference('AfsAccount.count', -1) do
      delete :destroy, id: @afs_account
    end

    assert_redirected_to afs_accounts_path
  end
end
