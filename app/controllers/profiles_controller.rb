class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def current_user_home
    profile = Profile.where(user_id: current_user).first
    redirect_to profile
  end

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # respond_to :json
  # def get_events
  #   @task = Calendars.all
  #   events = []
  #   @task.each do |task|
  #     # events << {:id => task.id, :title => "#{task.des} : #{task.task}", :start => "#{task.planned_start_date}",:end => "#{task.planned_end_date}" }
  #     events << task.as_json
  #   end
  #   render events.to_json
  # end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    current_staff = current_user.staff
    @calendars = Calendar.all
    @time_clocks = TimeClock.where(time_out: nil)
    puts @time_clocks.inspect
    if current_user.is_admin?
      # @calander
      @jobs = Job.where(job_closed: false).order('date_due ASC' )
      @calendars = Calendar.all
      # puts 'admin'

    else
      # puts 'not'
      @jobs = Job.where()
      @calendars = Calendar.all
    end
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.fetch(:profile, {})
    end
end
