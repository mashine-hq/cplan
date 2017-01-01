class StatisticsController < ApplicationController
  before_action :set_statistic, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # GET /statistics
  # GET /statistics.json
  def index
    @statistics = current_user.statistics.includes(:section).all
  end

  # GET /statistics/1
  # GET /statistics/1.json
  def show
    #stat_ids = [1, 3]
    stats = Statistic.where(id: params[:id]).all
    column_condition = stats.map { |stat| "sum(case when reports.statistic_id = '#{stat.id}' then summary else 0 end) AS #{stat.name}" }.join(",\n")
    result = Report.connection.select_all("SELECT report_at, #{column_condition} FROM reports GROUP BY report_at ORDER BY report_at")
    @stats = {columns: result.first.keys.to_a, rows: result.map(&:values)}
  end

  # GET /statistics/new
  def new
    @statistic = Statistic.new
    @departments =  current_user.departments
  end

  # GET /statistics/1/edit
  def edit
    @departments = current_user.departments
  end

  # POST /statistics
  # POST /statistics.json
  def create
    @departments =  current_user.departments
    @statistic = Statistic.new(statistic_params)
    @statistic.user = current_user
    respond_to do |format|
      if @statistic.save
        format.html { redirect_to statistics_url, notice: t('flash.success') }
        format.json { render :show, status: :created, location: @statistic }
      else
        format.html { render :new }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /statistics/1
  # PATCH/PUT /statistics/1.json
  def update
    respond_to do |format|
      if @statistic.update(statistic_params)
        format.html { redirect_to statistics_url, notice: t('flash.success') }
        format.json { render :show, status: :ok, location: @statistic }
      else
        format.html { render :edit }
        format.json { render json: @statistic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statistics/1
  # DELETE /statistics/1.json
  def destroy
    @statistic.destroy
    respond_to do |format|
      format.html { redirect_to statistics_url, notice: t('flash.success_destroy') }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_statistic
    @statistic = current_user.statistics.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def statistic_params
    params.require(:statistic).permit(:name, :user_id, :section_id, :units)
  end
end
