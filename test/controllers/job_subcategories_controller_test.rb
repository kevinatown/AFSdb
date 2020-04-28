require 'test_helper'

class JobSubcategoriesControllerTest < ActionController::TestCase
  setup do
    @job_subcategory = job_subcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_subcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_subcategory" do
    assert_difference('JobSubcategory.count') do
      post :create, job_subcategory: { name: @job_subcategory.name }
    end

    assert_redirected_to job_subcategory_path(assigns(:job_subcategory))
  end

  test "should show job_subcategory" do
    get :show, id: @job_subcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job_subcategory
    assert_response :success
  end

  test "should update job_subcategory" do
    patch :update, id: @job_subcategory, job_subcategory: { name: @job_subcategory.name }
    assert_redirected_to job_subcategory_path(assigns(:job_subcategory))
  end

  test "should destroy job_subcategory" do
    assert_difference('JobSubcategory.count', -1) do
      delete :destroy, id: @job_subcategory
    end

    assert_redirected_to job_subcategories_path
  end
end
