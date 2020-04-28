class AfsAccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_afs_account, only: [:show, :edit, :update, :destroy]

  # GET /afs_accounts
  # GET /afs_accounts.json
  def index
    @afs_accounts = AfsAccount.all
  end

  # GET /afs_accounts/1
  # GET /afs_accounts/1.json
  def show
  end

  # GET /afs_accounts/new
  def new
    @afs_account = AfsAccount.new
  end

  # GET /afs_accounts/1/edit
  def edit
  end

  # POST /afs_accounts
  # POST /afs_accounts.json
  def create
    @afs_account = AfsAccount.new(afs_account_params)

    respond_to do |format|
      if @afs_account.save
        format.html { redirect_to @afs_account, notice: 'Afs account was successfully created.' }
        format.json { render :show, status: :created, location: @afs_account }
      else
        format.html { render :new }
        format.json { render json: @afs_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /afs_accounts/1
  # PATCH/PUT /afs_accounts/1.json
  def update
    respond_to do |format|
      if @afs_account.update(afs_account_params)
        format.html { redirect_to @afs_account, notice: 'Afs account was successfully updated.' }
        format.json { render :show, status: :ok, location: @afs_account }
      else
        format.html { render :edit }
        format.json { render json: @afs_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /afs_accounts/1
  # DELETE /afs_accounts/1.json
  def destroy
    @afs_account.destroy
    respond_to do |format|
      format.html { redirect_to afs_accounts_url, notice: 'Afs account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_afs_account
      @afs_account = AfsAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def afs_account_params
      params.require(:afs_account).permit(:name)
    end
end
