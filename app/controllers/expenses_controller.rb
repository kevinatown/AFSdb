class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = Expense.all
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
    @expense.staff = current_user.staff
  end

  def new_job
    @expense = Expense.new
    @expense.date_incurred = DateTime.now
    @expense.staff = current_user.staff
    @expense.job = Job.find(params[:job])
    if params[:afs_account].present?
      @expense.afs_account = AfsAccount.find(params[:afs_account])
    end
    respond_to do |format|
        format.html { render :new }
        format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    # if params[:expense][:job].present?
    #   @expense.job = Job.find(params[:expense][:job])
    # end
    # if params[:expense][:expense_type].present?
    #   @expense.expense_type = ExpenseType.find(params[:expense][:expense_type])
    # end
    @expense.staff = Staff.where(id: params[:expense][:staff]).first
    respond_to do |format|
      if @expense.save
        update_job_expenses(@expense)
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    # @expense.job.clear
    # if params[:expense][:job].present?
    #   @expense.job = Job.find(params[:expense][:job])
    # end
    respond_to do |format|
      if @expense.update(expense_params)
        update_job_expenses(@expense)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    jobs = @expense.job
    @expense.destroy
    remove_job_expense(jobs)
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def remove_job_expense(j)
      if j.present?
        j.calc_material_cost #= sum(Expense.joins(:job).where("jobs.id = ?", j.id).to_a)
      end
    end

    def update_job_expenses(exp)
      if exp.job.present?
        exp.job.calc_material_cost #= sum(Expense.joins(:job).where("jobs.id = ?", j.id).to_a)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:expense_type_id, :job_id, :date_incurred,
        :vendor_name, :vendor_location, :description, :amount, :notes, :afs_account_id)
    end
end
