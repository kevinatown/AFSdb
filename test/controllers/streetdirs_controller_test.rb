require 'test_helper'

class StreetdirsControllerTest < ActionController::TestCase
  setup do
    @streetdir = streetdirs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:streetdirs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create streetdir" do
    assert_difference('Streetdir.count') do
      post :create, streetdir: { name: @streetdir.name }
    end

    assert_redirected_to streetdir_path(assigns(:streetdir))
  end

  test "should show streetdir" do
    get :show, id: @streetdir
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @streetdir
    assert_response :success
  end

  test "should update streetdir" do
    patch :update, id: @streetdir, streetdir: { name: @streetdir.name }
    assert_redirected_to streetdir_path(assigns(:streetdir))
  end

  test "should destroy streetdir" do
    assert_difference('Streetdir.count', -1) do
      delete :destroy, id: @streetdir
    end

    assert_redirected_to streetdirs_path
  end
end
