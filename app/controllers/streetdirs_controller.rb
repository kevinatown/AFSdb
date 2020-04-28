class StreetdirsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_streetdir, only: [:show, :edit, :update, :destroy]

  # GET /streetdirs
  # GET /streetdirs.json
  def index
    @streetdirs = Streetdir.all
  end

  # GET /streetdirs/1
  # GET /streetdirs/1.json
  def show
  end

  # GET /streetdirs/new
  def new
    @streetdir = Streetdir.new
  end

  # GET /streetdirs/1/edit
  def edit
  end

  # POST /streetdirs
  # POST /streetdirs.json
  def create
    @streetdir = Streetdir.new(streetdir_params)

    respond_to do |format|
      if @streetdir.save
        format.html { redirect_to @streetdir, notice: 'Streetdir was successfully created.' }
        format.json { render :show, status: :created, location: @streetdir }
      else
        format.html { render :new }
        format.json { render json: @streetdir.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /streetdirs/1
  # PATCH/PUT /streetdirs/1.json
  def update
    respond_to do |format|
      if @streetdir.update(streetdir_params)
        format.html { redirect_to @streetdir, notice: 'Streetdir was successfully updated.' }
        format.json { render :show, status: :ok, location: @streetdir }
      else
        format.html { render :edit }
        format.json { render json: @streetdir.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /streetdirs/1
  # DELETE /streetdirs/1.json
  def destroy
    @streetdir.destroy
    respond_to do |format|
      format.html { redirect_to streetdirs_url, notice: 'Streetdir was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_streetdir
      @streetdir = Streetdir.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def streetdir_params
      params.require(:streetdir).permit(:name)
    end
end
