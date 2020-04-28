class StaffsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
    @user = User.where(staff_id: params[:id]).first
  end

  # POST /staffs
  # POST /staffs.json
  def create
    # inspect params
    @staff = Staff.new(staff_params)
    if params[:staff][:phone].present?  
      @staff.phone = format_phone(@staff.phone)
    end
    if not params[:staff][:hire_date].present?
      @staff.hire_date =  DateTime.now 
    end
    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_password
    @staff = Staff.find(params[:user][:staff_id])
    @user = User.find(params[:user][:id])
    if params[:user][:password] != params[:user][:password_confirmation]
      flash[:alert] = "The passwords do not match."
      render :edit 
    elsif @user.update(params.require(:user).permit(:username, :password,:password_confirmation))
      flash[:notice] = "User was successfully updated."
      redirect_to @staff 
    else
      flash[:alert] = @user.errors.full_messages
      render :edit 
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    if params[:staff][:phone].present?
      @staff.phone = format_phone(@staff.phone) 
    end
    respond_to do |format|
      
      if @staff.update(staff_params)
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    def format_phone(num)
      num = num.delete("^0-9")
      num = '('+num[0, 3]+') '+num[3,3]+'-'+num[6,4]
      num
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      params.require(:staff).permit(:f_name, :m_name, :l_name, :skills, :is_admin,
        :limitations, :email, :phone, :street_number, :street_name, :suite, :city, :zip, :hire_date, 
        :termination_date, :position, :notes, :hourly_wage, :annual_salary, :state_id, :streetdir_id, 
        :street_type_id, driver_attributes: [ :driver_lic_num, :driver_lic_exp, :state ])
    end
end
