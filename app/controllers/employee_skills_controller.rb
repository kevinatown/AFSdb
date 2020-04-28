class EmployeeSkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee_skill, only: [:show, :edit, :update, :destroy]

  # GET /employee_skills
  # GET /employee_skills.json
  def index
    @employee_skills = EmployeeSkill.all
  end

  # GET /employee_skills/1
  # GET /employee_skills/1.json
  def show
  end

  # GET /employee_skills/new
  def new
    @employee_skill = EmployeeSkill.new
  end

  # GET /employee_skills/1/edit
  def edit
  end

  # POST /employee_skills
  # POST /employee_skills.json
  def create
    @employee_skill = EmployeeSkill.new(employee_skill_params)

    respond_to do |format|
      if @employee_skill.save
        format.html { redirect_to @employee_skill, notice: 'Employee skill was successfully created.' }
        format.json { render :show, status: :created, location: @employee_skill }
      else
        format.html { render :new }
        format.json { render json: @employee_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_skills/1
  # PATCH/PUT /employee_skills/1.json
  def update
    respond_to do |format|
      if @employee_skill.update(employee_skill_params)
        format.html { redirect_to @employee_skill, notice: 'Employee skill was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee_skill }
      else
        format.html { render :edit }
        format.json { render json: @employee_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_skills/1
  # DELETE /employee_skills/1.json
  def destroy
    @employee_skill.destroy
    respond_to do |format|
      format.html { redirect_to employee_skills_url, notice: 'Employee skill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_skill
      @employee_skill = EmployeeSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_skill_params
      params.require(:employee_skill).permit(:name)
    end
end
