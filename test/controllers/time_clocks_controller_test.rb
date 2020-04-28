require 'test_helper'

class TimeClocksControllerTest < ActionController::TestCase
  setup do
    @time_clock = time_clocks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:time_clocks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create time_clock" do
    assert_difference('TimeClock.count') do
      post :create, time_clock: { lat_in: @time_clock.lat_in, lat_out: @time_clock.lat_out, long_in: @time_clock.long_in, long_out: @time_clock.long_out, notes: @time_clock.notes, time_in: @time_clock.time_in, time_out: @time_clock.time_out }
    end

    assert_redirected_to time_clock_path(assigns(:time_clock))
  end

  test "should show time_clock" do
    get :show, id: @time_clock
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @time_clock
    assert_response :success
  end

  test "should update time_clock" do
    patch :update, id: @time_clock, time_clock: { lat_in: @time_clock.lat_in, lat_out: @time_clock.lat_out, long_in: @time_clock.long_in, long_out: @time_clock.long_out, notes: @time_clock.notes, time_in: @time_clock.time_in, time_out: @time_clock.time_out }
    assert_redirected_to time_clock_path(assigns(:time_clock))
  end

  test "should destroy time_clock" do
    assert_difference('TimeClock.count', -1) do
      delete :destroy, id: @time_clock
    end

    assert_redirected_to time_clocks_path
  end
end
