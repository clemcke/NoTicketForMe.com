class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @report = current_user.reports.new(params[:report])
    @report.save ? redirect_to(show_report_path(@report)) : render(:action => :new)
  end

  def new
    @report = current_user.reports.new(:date => Date.today)
  end

  def show
  end

end
