class WasteSystemsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_waste_system, only: [:show, :edit, :update, :destroy]

  # GET /waste_systems
  # GET /waste_systems.json
  def index
    @waste_systems = WasteSystem.all
  end

  # GET /waste_systems/1
  # GET /waste_systems/1.json
  def show
  end

  # GET /waste_systems/new
  def new
    @waste_system = WasteSystem.new
  end

  # GET /waste_systems/1/edit
  def edit
  end

  # POST /waste_systems
  # POST /waste_systems.json
  def create
    @waste_system = WasteSystem.new(waste_system_params)

    respond_to do |format|
      if @waste_system.save
        format.html { redirect_to @waste_system, notice: 'Waste system was successfully created.' }
        format.json { render :show, status: :created, location: @waste_system }
      else
        format.html { render :new }
        format.json { render json: @waste_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /waste_systems/1
  # PATCH/PUT /waste_systems/1.json
  def update
    respond_to do |format|
      if @waste_system.update(waste_system_params)
        format.html { redirect_to @waste_system, notice: 'Waste system was successfully updated.' }
        format.json { render :show, status: :ok, location: @waste_system }
      else
        format.html { render :edit }
        format.json { render json: @waste_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /waste_systems/1
  # DELETE /waste_systems/1.json
  def destroy
    @waste_system.destroy
    respond_to do |format|
      format.html { redirect_to waste_systems_url, notice: 'Waste system was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_waste_system
      @waste_system = WasteSystem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def waste_system_params
      params.require(:waste_system).permit(:name)
    end
end
