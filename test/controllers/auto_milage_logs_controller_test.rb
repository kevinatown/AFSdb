require 'test_helper'

class AutoMilageLogsControllerTest < ActionController::TestCase
  setup do
    @auto_milage_log = auto_milage_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auto_milage_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auto_milage_log" do
    assert_difference('AutoMilageLog.count') do
      post :create, auto_milage_log: { date_in: @auto_milage_log.date_in, mileage_in: @auto_milage_log.mileage_in, mileage_out: @auto_milage_log.mileage_out, time_out: @auto_milage_log.time_out }
    end

    assert_redirected_to auto_milage_log_path(assigns(:auto_milage_log))
  end

  test "should show auto_milage_log" do
    get :show, id: @auto_milage_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @auto_milage_log
    assert_response :success
  end

  test "should update auto_milage_log" do
    patch :update, id: @auto_milage_log, auto_milage_log: { date_in: @auto_milage_log.date_in, mileage_in: @auto_milage_log.mileage_in, mileage_out: @auto_milage_log.mileage_out, time_out: @auto_milage_log.time_out }
    assert_redirected_to auto_milage_log_path(assigns(:auto_milage_log))
  end

  test "should destroy auto_milage_log" do
    assert_difference('AutoMilageLog.count', -1) do
      delete :destroy, id: @auto_milage_log
    end

    assert_redirected_to auto_milage_logs_path
  end
end
