require 'test_helper'

class StaffsControllerTest < ActionController::TestCase
  setup do
    @staff = staffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff" do
    assert_difference('Staff.count') do
      post :create, staff: { annual_salary: @staff.annual_salary, city: @staff.city, driver_lic_exp: @staff.driver_lic_exp, driver_lic_num: @staff.driver_lic_num, email: @staff.email, f_name: @staff.f_name, hire_date: @staff.hire_date, hourly_wage: @staff.hourly_wage, l_name: @staff.l_name, limitations: @staff.limitations, m_name: @staff.m_name, notes: @staff.notes, phone: @staff.phone, position: @staff.position, skills: @staff.skills, street_name: @staff.street_name, street_num: @staff.street_num, suite: @staff.suite, termination_date: @staff.termination_date, zip: @staff.zip }
    end

    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should show staff" do
    get :show, id: @staff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @staff
    assert_response :success
  end

  test "should update staff" do
    patch :update, id: @staff, staff: { annual_salary: @staff.annual_salary, city: @staff.city, driver_lic_exp: @staff.driver_lic_exp, driver_lic_num: @staff.driver_lic_num, email: @staff.email, f_name: @staff.f_name, hire_date: @staff.hire_date, hourly_wage: @staff.hourly_wage, l_name: @staff.l_name, limitations: @staff.limitations, m_name: @staff.m_name, notes: @staff.notes, phone: @staff.phone, position: @staff.position, skills: @staff.skills, street_name: @staff.street_name, street_num: @staff.street_num, suite: @staff.suite, termination_date: @staff.termination_date, zip: @staff.zip }
    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should destroy staff" do
    assert_difference('Staff.count', -1) do
      delete :destroy, id: @staff
    end

    assert_redirected_to staffs_path
  end
end
