require 'test_helper'

class PropertiesControllerTest < ActionController::TestCase
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post :create, property: { bldg_sqr_feet: @property.bldg_sqr_feet, city: @property.city, lockbox_code: @property.lockbox_code, lot_acreage: @property.lot_acreage, lot_sqr_feet: @property.lot_sqr_feet, notes: @property.notes, street_name: @property.street_name, street_number: @property.street_number, suite: @property.suite, year_built: @property.year_built, zip: @property.zip }
    end

    assert_redirected_to property_path(assigns(:property))
  end

  test "should show property" do
    get :show, id: @property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property
    assert_response :success
  end

  test "should update property" do
    patch :update, id: @property, property: { bldg_sqr_feet: @property.bldg_sqr_feet, city: @property.city, lockbox_code: @property.lockbox_code, lot_acreage: @property.lot_acreage, lot_sqr_feet: @property.lot_sqr_feet, notes: @property.notes, street_name: @property.street_name, street_number: @property.street_number, suite: @property.suite, year_built: @property.year_built, zip: @property.zip }
    assert_redirected_to property_path(assigns(:property))
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete :destroy, id: @property
    end

    assert_redirected_to properties_path
  end
end
