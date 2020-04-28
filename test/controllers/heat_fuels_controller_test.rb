require 'test_helper'

class HeatFuelsControllerTest < ActionController::TestCase
  setup do
    @heat_fuel = heat_fuels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:heat_fuels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create heat_fuel" do
    assert_difference('HeatFuel.count') do
      post :create, heat_fuel: { name: @heat_fuel.name }
    end

    assert_redirected_to heat_fuel_path(assigns(:heat_fuel))
  end

  test "should show heat_fuel" do
    get :show, id: @heat_fuel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @heat_fuel
    assert_response :success
  end

  test "should update heat_fuel" do
    patch :update, id: @heat_fuel, heat_fuel: { name: @heat_fuel.name }
    assert_redirected_to heat_fuel_path(assigns(:heat_fuel))
  end

  test "should destroy heat_fuel" do
    assert_difference('HeatFuel.count', -1) do
      delete :destroy, id: @heat_fuel
    end

    assert_redirected_to heat_fuels_path
  end
end
