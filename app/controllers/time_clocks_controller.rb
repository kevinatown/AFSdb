class TimeClocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_clock, only: [:show, :edit, :update, :destroy], except: [:payroll]
  before_action :determin_admin, only: [:destroy]

  # GET /time_clocks
  # GET /time_clocks.json
  def index
    if current_user.is_admin?
      @time_clocks = TimeClock.all
    else
      @time_clocks = TimeClock.where(staff: current_user.staff)
    end
  end

  # def payroll

  # end

  # POST
  def payroll
    if params[:payroll].present? and params[:payroll][:start_date].present? and params[:payroll][:end_date].present?
      start_date = params[:payroll][:start_date].to_date.beginning_of_day
      end_date = params[:payroll][:end_date].to_date.end_of_day
      @time_clocks = TimeClock.where(time_in: start_date..end_date)
      if params[:payroll][:staff].present?
        @time_clocks = @time_clocks.where(staff_id: params[:payroll][:staff])
      end 
      respond_to do |format|
        format.html { render :payroll }
      end
    end
  end

  # GET /time_clocks/1
  # GET /time_clocks/1.json
  def show
  end

  # GET /time_clocks/new
  def new
    @time_clock = TimeClock.new
    @time_clock.time_in = DateTime.now
    @time_clock.lat_in = params[:lat]
    @time_clock.long_in = params[:long]
    @time_clock.staff = current_user.staff
    respond_to do |format|
        format.html { render :new }
        format.json { render json: @time_clock }
    end
  end

  def new_job
    # puts params
    @time_clock = TimeClock.new
    @time_clock.time_in = DateTime.now
    @time_clock.staff = current_user.staff
    # puts Job.find(params[:job]).name
    @time_clock.job = Job.find(params[:job])
    respond_to do |format|
        format.html { render :new }
        format.json { render json: @time_clock }
    end
  end

  # GET /time_clocks/1/edit
  def edit
  end

  # POST /time_clocks
  # POST /time_clocks.json
  def create
    @time_clock = TimeClock.new(time_clock_params)
    if params[:time_clock][:job].present?
      @time_clock.job = Job.find(params[:time_clock][:job])
    end
    @time_clock.staff = Staff.where(id: params[:time_clock][:staff]).first
    tz = ActiveSupport::TimeZone.new("Eastern Time (US & Canada)")
    if params[:time_clock][:time_in].present?
      puts params[:time_clock][:time_in]
      # 'Eastern Time (US & Canada)'
      # puts ActiveSupport::TimeZone[config.time_zone].parse()
      # @time_clock.time_in = DateTime.strptime(params[:time_clock][:time_in] + ' Eastern Time (US & Canada)', '%m/%e/%Y %I:%M %p %z')
      # @time_clock.time_in = Time.zone.strptime(params[:time_clock][:time_in], '%m/%e/%Y %I:%M %p')
      @time_clock.time_in = Time.strptime(params[:time_clock][:time_in], '%m/%e/%Y %I:%M %p')
      puts @time_clock.time_in
    end
    if params[:time_clock][:time_out].present?
      puts params[:time_clock][:time_out]
      @time_clock.time_out = Time.strptime(params[:time_clock][:time_out], '%m/%e/%Y %I:%M %p')
    end
    if !current_user.is_admin?
      @time_clock.staff = current_user.staff
    end
    respond_to do |format|
      if @time_clock.save
        if @time_clock.time_out.present?
          update_job_wages(@time_clock)
        end
        format.html { redirect_to profile_path(current_user.profile), data: { no_turbolink: true }, notice: 'Welcome to work!' }
        format.json { render :show, status: :created, location: @time_clock }
        # format.html { redirect_to @time_clock, notice: 'Clocked in.' }
        # format.json { render :show, status: :created, location: @time_clock }
      else
        format.html { render :new }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_clocks/1
  # PATCH/PUT /time_clocks/1.json
  def update
    @time_clock.job
    puts params
    if params[:time_clock][:job].present?
      @time_clock.job = Job.find(params[:time_clock][:job])
    end
    if params[:time_clock][:time_in].present?
      puts @time_clock.time_in
      puts params[:time_clock][:time_in]
      @time_clock.time_in = Time.strptime(params[:time_clock][:time_in], '%m/%e/%Y %I:%M %p')
      puts @time_clock.time_in
    end
    if params[:time_clock][:time_out].present?
      puts @time_clock.time_out
      puts params[:time_clock][:time_out]
      @time_clock.time_out = Time.strptime(params[:time_clock][:time_out], '%m/%e/%Y %I:%M %p')
      puts @time_clock.time_out
    end
    respond_to do |format|
      if @time_clock.update(time_clock_params)
        if @time_clock.time_out.present?
          update_job_wages(@time_clock)
        end
        format.html { redirect_to @time_clock, notice: 'Time clock was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_clock }
      else
        format.html { render :edit }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_clocks/1
  # DELETE /time_clocks/1.json
  def destroy
    j= @time_clock.job
    @time_clock.destroy
    remove_job_wages(j)
    respond_to do |format|
      format.html { redirect_to time_clocks_url, notice: 'Time clock was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sign_in
    @time_clock = TimeClock.new
    @time_clock.staff = current_user.staff
    @time_clock.time_in = DateTime.now
    @time_clock.lat_in = params[:lat]
    @time_clock.long_in = params[:long]
    @jobs = Job.where(is_closed: false)
    respond_to do |format|
        format.html { render :new_no_f, :layout => false  }  # show.html.erb
        format.json { render json: @time_clock }
    end

  end

  def sign_out
    if params[:time_clock].present?
      @time_clock = TimeClock.find(params[:time_clock])
    else
      @time_clock = current_user.get_time_clock
    end
    @time_clock.time_out = DateTime.now
    @time_clock.lat_out = params[:lat]
    @time_clock.long_out = params[:long]   
    respond_to do |format|
      if @time_clock.save
        if @time_clock.time_out.present?
          update_job_wages(@time_clock)
        end
        format.html { redirect_to profile_path(current_user.profile), data: { no_turbolink: true }, notice: 'See ya!' }
        # format.json { render :show, status: :created, location: @tc }
      else
        format.html { render :new_no_f }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def determin_admin
      if not current_user.is_admin?
        respond_to do |format|
          # format.html { redirect_to :authenticated_root, notice: 'You clocked in!' }
          format.html { redirect_to profile_path(current_user.profile), alert: "You do not have those privileges."  }
        end
      end
    end

    def remove_job_wages(j)
      if j.present?
        j.calc_wages_paid #= sum(Expense.joins(:job).where("jobs.id = ?", j.id).to_a)
      end
    end

    def update_job_wages(tc)
      if tc.job.present?
        tc.job.calc_wages_paid #= sum(Expense.joins(:job).where("jobs.id = ?", j.id).to_a)
        # tc.job.save!
      end
    end

    def set_time_clock
      @time_clock = TimeClock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_clock_params
      if current_user.is_admin?  
        params.require(:time_clock).permit( :lat_in, :long_in, :lat_out, :long_out, :notes, :job_id)
      else
        params.require(:time_clock).permit( :lat_in, :long_in, :lat_out, :long_out, :notes, :job_id)
      end
    end
end
