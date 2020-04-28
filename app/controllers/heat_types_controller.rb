class HeatTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_heat_type, only: [:show, :edit, :update, :destroy]

  # GET /heat_types
  # GET /heat_types.json
  def index
    @heat_types = HeatType.all
  end

  # GET /heat_types/1
  # GET /heat_types/1.json
  def show
  end

  # GET /heat_types/new
  def new
    @heat_type = HeatType.new
  end

  # GET /heat_types/1/edit
  def edit
  end

  # POST /heat_types
  # POST /heat_types.json
  def create
    @heat_type = HeatType.new(heat_type_params)

    respond_to do |format|
      if @heat_type.save
        format.html { redirect_to @heat_type, notice: 'Heat type was successfully created.' }
        format.json { render :show, status: :created, location: @heat_type }
      else
        format.html { render :new }
        format.json { render json: @heat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heat_types/1
  # PATCH/PUT /heat_types/1.json
  def update
    respond_to do |format|
      if @heat_type.update(heat_type_params)
        format.html { redirect_to @heat_type, notice: 'Heat type was successfully updated.' }
        format.json { render :show, status: :ok, location: @heat_type }
      else
        format.html { render :edit }
        format.json { render json: @heat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heat_types/1
  # DELETE /heat_types/1.json
  def destroy
    @heat_type.destroy
    respond_to do |format|
      format.html { redirect_to heat_types_url, notice: 'Heat type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heat_type
      @heat_type = HeatType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heat_type_params
      params.require(:heat_type).permit(:name)
    end
end
