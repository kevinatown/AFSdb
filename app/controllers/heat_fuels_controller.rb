class HeatFuelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_heat_fuel, only: [:show, :edit, :update, :destroy]

  # GET /heat_fuels
  # GET /heat_fuels.json
  def index
    @heat_fuels = HeatFuel.all
  end

  # GET /heat_fuels/1
  # GET /heat_fuels/1.json
  def show
  end

  # GET /heat_fuels/new
  def new
    @heat_fuel = HeatFuel.new
  end

  # GET /heat_fuels/1/edit
  def edit
  end

  # POST /heat_fuels
  # POST /heat_fuels.json
  def create
    @heat_fuel = HeatFuel.new(heat_fuel_params)

    respond_to do |format|
      if @heat_fuel.save
        format.html { redirect_to @heat_fuel, notice: 'Heat fuel was successfully created.' }
        format.json { render :show, status: :created, location: @heat_fuel }
      else
        format.html { render :new }
        format.json { render json: @heat_fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heat_fuels/1
  # PATCH/PUT /heat_fuels/1.json
  def update
    respond_to do |format|
      if @heat_fuel.update(heat_fuel_params)
        format.html { redirect_to @heat_fuel, notice: 'Heat fuel was successfully updated.' }
        format.json { render :show, status: :ok, location: @heat_fuel }
      else
        format.html { render :edit }
        format.json { render json: @heat_fuel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heat_fuels/1
  # DELETE /heat_fuels/1.json
  def destroy
    @heat_fuel.destroy
    respond_to do |format|
      format.html { redirect_to heat_fuels_url, notice: 'Heat fuel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heat_fuel
      @heat_fuel = HeatFuel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def heat_fuel_params
      params.require(:heat_fuel).permit(:name)
    end
end
