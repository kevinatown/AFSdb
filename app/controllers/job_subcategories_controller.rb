class JobSubcategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_subcategory, only: [:show, :edit, :update, :destroy]

  # GET /job_subcategories
  # GET /job_subcategories.json
  def index
    @job_subcategories = JobSubcategory.all
  end

  # GET /job_subcategories/1
  # GET /job_subcategories/1.json
  def show
  end

  # GET /job_subcategories/new
  def new
    @job_subcategory = JobSubcategory.new
  end

  # GET /job_subcategories/1/edit
  def edit
  end

  # POST /job_subcategories
  # POST /job_subcategories.json
  def create
    @job_subcategory = JobSubcategory.new(job_subcategory_params)

    respond_to do |format|
      if @job_subcategory.save
        format.html { redirect_to @job_subcategory, notice: 'Job subcategory was successfully created.' }
        format.json { render :show, status: :created, location: @job_subcategory }
      else
        format.html { render :new }
        format.json { render json: @job_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_subcategories/1
  # PATCH/PUT /job_subcategories/1.json
  def update
    respond_to do |format|
      if @job_subcategory.update(job_subcategory_params)
        format.html { redirect_to @job_subcategory, notice: 'Job subcategory was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_subcategory }
      else
        format.html { render :edit }
        format.json { render json: @job_subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_subcategories/1
  # DELETE /job_subcategories/1.json
  def destroy
    @job_subcategory.destroy
    respond_to do |format|
      format.html { redirect_to job_subcategories_url, notice: 'Job subcategory was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_subcategory
      @job_subcategory = JobSubcategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_subcategory_params
      params.require(:job_subcategory).permit(:name)
    end
end
