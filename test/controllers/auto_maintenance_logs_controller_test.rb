require 'test_helper'

class AutoMaintenanceLogsControllerTest < ActionController::TestCase
  setup do
    @auto_maintenance_log = auto_maintenance_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:auto_maintenance_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create auto_maintenance_log" do
    assert_difference('AutoMaintenanceLog.count') do
      post :create, auto_maintenance_log: { car: @auto_maintenance_log.car, cost: @auto_maintenance_log.cost, notes: @auto_maintenance_log.notes, service_completed: @auto_maintenance_log.service_completed, service_date: @auto_maintenance_log.service_date, service_vendor: @auto_maintenance_log.service_vendor }
    end

    assert_redirected_to auto_maintenance_log_path(assigns(:auto_maintenance_log))
  end

  test "should show auto_maintenance_log" do
    get :show, id: @auto_maintenance_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @auto_maintenance_log
    assert_response :success
  end

  test "should update auto_maintenance_log" do
    patch :update, id: @auto_maintenance_log, auto_maintenance_log: { car: @auto_maintenance_log.car, cost: @auto_maintenance_log.cost, notes: @auto_maintenance_log.notes, service_completed: @auto_maintenance_log.service_completed, service_date: @auto_maintenance_log.service_date, service_vendor: @auto_maintenance_log.service_vendor }
    assert_redirected_to auto_maintenance_log_path(assigns(:auto_maintenance_log))
  end

  test "should destroy auto_maintenance_log" do
    assert_difference('AutoMaintenanceLog.count', -1) do
      delete :destroy, id: @auto_maintenance_log
    end

    assert_redirected_to auto_maintenance_logs_path
  end
end
