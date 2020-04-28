class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :edit, :update, :destroy, :invoice]
  before_action :determin_admin, only: [:destroy, :new, :create, :edit]

  # GET /jobs
  # GET /jobs.json
  def index
    if current_user.is_admin?
      @jobs = Job.all
      @jobs_open = Job.where("status = 2 and !(date_invoiced is NOT NULL and date_invoiced != '')")
      @jobs_bids = Job.where(status: 1)
    else
      @jobs = Job.joins(:staff).where("staffs.id = ?", current_user.staff.id)
      @jobs_open = Job.joins(:staff).where("staffs.id = ?", current_user.staff.id).where(status: 2)
      @jobs_bids = Job.joins(:staff).where("staffs.id = ?", current_user.staff.id).where(status: 1)
    end  
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @timeclocks = @job.time_clocks
    @expenses = @job.expenses
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  def new_job
    @job = Job.new
    @job.date_assigned = DateTime.now
    @job.property = Property.find(params[:property])
    respond_to do |format|
        format.html { render :new }
        format.json { render json: @expense }
    end
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    if params[:job][:staff].present?
      params[:job][:staff].each do |s|
        @job.staff << Staff.where(id: s)
      end
    end
    if params[:job][:contractor].present?
     @job.contractor = Contractor.find(params[:job][:contractor])
    end
    if params[:job][:date_completed].present? and params[:job][:date_payment_recv].present? and params[:job][:date_completed] <= Time.now and params[:job][:date_payment_recv] <= Time.now
      @job.status = 0
    end
    puts @job.inspect
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def invoices
    @jobs = Job.where("date_invoiced is NOT NULL and date_invoiced != '' and (date_payment_recv is NULL or date_payment_recv = '')")
  end

  def invoice
    # respond_to do |format|
    #     format.html { render :invoice, :layout => false  }  # show.html.erb
    #     format.json { render json: @job }
    # end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
     if params[:job][:staff].present?
      @job.staff.clear
      params[:job][:staff].each do |s|
        @job.staff << Staff.where(id: s)
      end
    end
    if params[:job][:contractor].present?
      @job.contractor = Contractor.find(params[:job][:contractor])
    end
    if params[:job][:date_completed].present? and params[:job][:date_payment_recv].present? and params[:job][:date_completed] <= Time.now and params[:job][:date_payment_recv] <= Time.now
      @job.status = 0
    end
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end
    
    def determin_admin
      if not current_user.is_admin?
        respond_to do |format|
          # format.html { redirect_to :authenticated_root, notice: 'You clocked in!' }
          format.html { redirect_to profile_path(current_user.profile), alert: "You do not have those privileges."  }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      if current_user.is_admin?  
        params.require(:job).permit(:date_approved, :date_due, :tasks, :date_completed, :afs_price, 
          :contractor_price, :wages_paid, :materials_cost, :misc_cost, :date_invoiced, 
          :anticipated_payment_date, :invoice, :date_payment_recv, :payment, 
          :client_check_number, :notes_for_office_staff, :notes_for_field_staff, 
          :notes_for_client, :date_assigned, :client_id, :job_category_id, :job_subcategory_id, :property_id,
          :contact_id, :contractor_id, :status)
      else
        params.require(:job).permit(:notes_for_office_staff)
        
      end
    end
end