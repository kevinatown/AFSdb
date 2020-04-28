class CalendarsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]
  before_action :determin_admin, only: [:edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @calendar = Calendar.find(params[:id])

    respond_to do |format|
        format.html { render :show, :layout => false  }  # show.html.erb
        # format.js # show.js.erb
        format.json { render json: @calendar }
    end
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
    @staffs = Staff.all
    @drivers = Driver.all
    @cars = Car.all
    @contractors = Contractor.all
    @event_types = EventType.all
    @jobs = Job.where(is_closed: false)
    # @jobs.each do |j|
    #   j.name
    # end
    respond_to do |format|
        format.html { render :new, :layout => false  }  # show.html.erb
        # format.js # show.js.erb
        format.json { render json: @calendar }
    end
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)
    @calendar.event_start = DateTime.strptime(params[:calendar][:event_start], '%m/%d/%Y %l:%M %p')
    if params[:calendar][:event_finish].present?
      @calendar.event_finish = DateTime.strptime(params[:calendar][:event_finish], '%m/%d/%Y %l:%M %p')
    end
    params[:calendar][:staff].each do |s|
      @calendar.staff << Staff.where(id: s)
    end
    params[:calendar][:driver].each do |s|
      @calendar.driver << Driver.where(id: s)
    end

    respond_to do |format|

      if @calendar.save
        format.html { redirect_to :authenticated_root, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar}
      else
        @staffs = Staff.all
        @drivers = Driver.all
        @cars = Car.all
        @contractors = Contractor.all
        @event_types = EventType.all
        @jobs = Job.where(is_closed: false)
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    @calendar.event_start = DateTime.strptime(params[:calendar][:event_start], '%m/%d/%Y %l:%M %p')
    if params[:calendar][:event_finish].present?
      @calendar.event_finish = DateTime.strptime(params[:calendar][:event_finish], '%m/%d/%Y %l:%M %p')
    end
    if params[:calendar][:staff].present?
      params[:calendar][:staff].each do |s|
        @calendar.staff << Staff.where(id: s)
      end
    end
    if params[:calendar][:driver].present?
      params[:calendar][:driver].each do |s|
        @calendar.driver << Driver.where(id: s)
      end
    end
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
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
    def calendar_params
      params.require(:calendar).permit(:event_start, :event_finish, :description, :location, :staff, :driver, :notes)
    end
end
