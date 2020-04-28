class ContractorCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contractor_category, only: [:show, :edit, :update, :destroy]

  # GET /contractor_categories
  # GET /contractor_categories.json
  def index
    @contractor_categories = ContractorCategory.all
  end

  # GET /contractor_categories/1
  # GET /contractor_categories/1.json
  def show
  end

  # GET /contractor_categories/new
  def new
    @contractor_category = ContractorCategory.new
  end

  # GET /contractor_categories/1/edit
  def edit
  end

  # POST /contractor_categories
  # POST /contractor_categories.json
  def create
    @contractor_category = ContractorCategory.new(contractor_category_params)

    respond_to do |format|
      if @contractor_category.save
        format.html { redirect_to @contractor_category, notice: 'Contractor category was successfully created.' }
        format.json { render :show, status: :created, location: @contractor_category }
      else
        format.html { render :new }
        format.json { render json: @contractor_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contractor_categories/1
  # PATCH/PUT /contractor_categories/1.json
  def update
    respond_to do |format|
      if @contractor_category.update(contractor_category_params)
        format.html { redirect_to @contractor_category, notice: 'Contractor category was successfully updated.' }
        format.json { render :show, status: :ok, location: @contractor_category }
      else
        format.html { render :edit }
        format.json { render json: @contractor_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contractor_categories/1
  # DELETE /contractor_categories/1.json
  def destroy
    @contractor_category.destroy
    respond_to do |format|
      format.html { redirect_to contractor_categories_url, notice: 'Contractor category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contractor_category
      @contractor_category = ContractorCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contractor_category_params
      params.require(:contractor_category).permit(:name)
    end
end
