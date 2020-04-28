require 'test_helper'

class ContractorCategoriesControllerTest < ActionController::TestCase
  setup do
    @contractor_category = contractor_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contractor_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contractor_category" do
    assert_difference('ContractorCategory.count') do
      post :create, contractor_category: { name: @contractor_category.name }
    end

    assert_redirected_to contractor_category_path(assigns(:contractor_category))
  end

  test "should show contractor_category" do
    get :show, id: @contractor_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contractor_category
    assert_response :success
  end

  test "should update contractor_category" do
    patch :update, id: @contractor_category, contractor_category: { name: @contractor_category.name }
    assert_redirected_to contractor_category_path(assigns(:contractor_category))
  end

  test "should destroy contractor_category" do
    assert_difference('ContractorCategory.count', -1) do
      delete :destroy, id: @contractor_category
    end

    assert_redirected_to contractor_categories_path
  end
end
