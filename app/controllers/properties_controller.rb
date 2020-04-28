class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    if params[:property][:state_id].present?
      @property.state = State.find(params[:property][:state_id])
    end
    if params[:property][:street_type_id].present?
      @property.street_type = StreetType.find(params[:property][:street_type_id])
    end
    if params[:property][:street_dir_id].present?
      @property.streetdir = Streetdir.find(params[:property][:street_dir_id])
    end
    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    if params[:property][:state_id].present?
      @property.state = State.find(params[:property][:state_id])
    end
    if params[:property][:street_type_id].present?
      @property.street_type = StreetType.find(params[:property][:street_type_id])
    end
    if params[:property][:street_dir_id].present?
      @property.streetdir = Streetdir.find(params[:property][:street_dir_id])
    end
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:street_number, :street_name, :suite, :city, :zip, :is_closed, :bldg_sqr_feet, :lot_sqr_feet, :lot_acreage, :year_built, :notes, :lockbox_code)
    end
end
