require 'test_helper'

class WaterSourcesControllerTest < ActionController::TestCase
  setup do
    @water_source = water_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:water_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create water_source" do
    assert_difference('WaterSource.count') do
      post :create, water_source: { name: @water_source.name }
    end

    assert_redirected_to water_source_path(assigns(:water_source))
  end

  test "should show water_source" do
    get :show, id: @water_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @water_source
    assert_response :success
  end

  test "should update water_source" do
    patch :update, id: @water_source, water_source: { name: @water_source.name }
    assert_redirected_to water_source_path(assigns(:water_source))
  end

  test "should destroy water_source" do
    assert_difference('WaterSource.count', -1) do
      delete :destroy, id: @water_source
    end

    assert_redirected_to water_sources_path
  end
end
