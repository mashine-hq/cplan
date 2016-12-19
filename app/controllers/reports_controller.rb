class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = current_user.reports.includes(:department).all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.statistic_id = params[:statistic_id]
    respond_to do |format|
      if @report.save
        format.html { redirect_to statistic_path(@report.statistic_id), notice: t('flash.success') }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to statistic_path(@report.statistic_id), notice: t('flash.success') }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to statistic_path(@report.statistic_id), notice: t('flash.success_destroy') }
      format.json { head :no_content }
    end
  end

  private

  def set_report
    @report = Statistic.where(id: statistic_id, user_id: current_user.id).reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:report_at, :units)
  end
end
