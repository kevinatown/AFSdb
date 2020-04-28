require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job" do
    assert_difference('Job.count') do
      post :create, job: { afs_price: @job.afs_price, anticipated_payment_date: @job.anticipated_payment_date, client_check_number: @job.client_check_number, contractor_price: @job.contractor_price, date_approved: @job.date_approved, date_completed: @job.date_completed, date_due: @job.date_due, date_invoiced: @job.date_invoiced, date_payment_recv: @job.date_payment_recv, invoice_number: @job.invoice_number, job_closed: @job.job_closed, materials_cost: @job.materials_cost, misc_cost: @job.misc_cost, notes_for_client: @job.notes_for_client, notes_for_feild_staff: @job.notes_for_feild_staff, notes_for_office_staff: @job.notes_for_office_staff, payment: @job.payment, tasks: @job.tasks, wages_paid: @job.wages_paid }
    end

    assert_redirected_to job_path(assigns(:job))
  end

  test "should show job" do
    get :show, id: @job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job
    assert_response :success
  end

  test "should update job" do
    patch :update, id: @job, job: { afs_price: @job.afs_price, anticipated_payment_date: @job.anticipated_payment_date, client_check_number: @job.client_check_number, contractor_price: @job.contractor_price, date_approved: @job.date_approved, date_completed: @job.date_completed, date_due: @job.date_due, date_invoiced: @job.date_invoiced, date_payment_recv: @job.date_payment_recv, invoice_number: @job.invoice_number, job_closed: @job.job_closed, materials_cost: @job.materials_cost, misc_cost: @job.misc_cost, notes_for_client: @job.notes_for_client, notes_for_feild_staff: @job.notes_for_feild_staff, notes_for_office_staff: @job.notes_for_office_staff, payment: @job.payment, tasks: @job.tasks, wages_paid: @job.wages_paid }
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    assert_difference('Job.count', -1) do
      delete :destroy, id: @job
    end

    assert_redirected_to jobs_path
  end
end
