class ReportsController < ApplicationController
  before_filter :authenticate_user!, :activation_required
  before_filter :reporter_required, :only => [:show]

  def create
    @report = current_user.reports.new(params[:report])
    @report.save ? redirect_to(reports_path(@report)) : render(:action => :new)
  end

  def new
    @report = current_user.reports.new(:date => Date.today)
  end

  def show
  end

  private
  def activation_required
    if user_signed_in? && !current_user.activated?
      case current_user.activation.status
        when "new"
          redirect_to activate_new_path
        when "in_progress"
          redirect_to activate_in_progress_path
        else
          redirect_to activate_in_progress_path
      end
    end
  end

  def reporter_required
    @report = Report.find params[:id]
    redirect_to root_url unless @report.user == current_user
  end
end
