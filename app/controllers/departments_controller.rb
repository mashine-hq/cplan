class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # GET /departments
  # GET /departments.json
  def index
    @departments = current_user.departments.ordered.all
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @stats = []
    # @stats = @department.statistics.all
    # unless @stats.empty?
    #   column_condition = @stats.map { |stat| "sum(case when reports.statistic_id = '#{stat.id}' then units else 0 end) AS #{stat.name}" }.join(",\n")
    #   result = Report.connection.select_all("SELECT report_at, #{column_condition} FROM reports GROUP BY report_at ORDER BY report_at")
    #   @stats = {columns: result.first.keys.to_a, rows: result.map(&:values)}
    # else
    #   @stats = {columns: [], rows: []}
    # end
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)
    @department.user = current_user
    respond_to do |format|
      if @department.save
        format.html { redirect_to departments_url, notice: t('flash.success') }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to departments_url, notice: t('flash.success') }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: t('flash.success_destroy') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = current_user.departments.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def department_params
    params.require(:department).permit(:user_id, :name, :position)
  end
end
