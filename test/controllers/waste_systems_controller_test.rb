require 'test_helper'

class WasteSystemsControllerTest < ActionController::TestCase
  setup do
    @waste_system = waste_systems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:waste_systems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create waste_system" do
    assert_difference('WasteSystem.count') do
      post :create, waste_system: { name: @waste_system.name }
    end

    assert_redirected_to waste_system_path(assigns(:waste_system))
  end

  test "should show waste_system" do
    get :show, id: @waste_system
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @waste_system
    assert_response :success
  end

  test "should update waste_system" do
    patch :update, id: @waste_system, waste_system: { name: @waste_system.name }
    assert_redirected_to waste_system_path(assigns(:waste_system))
  end

  test "should destroy waste_system" do
    assert_difference('WasteSystem.count', -1) do
      delete :destroy, id: @waste_system
    end

    assert_redirected_to waste_systems_path
  end
end
