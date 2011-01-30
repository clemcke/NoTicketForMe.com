class ReportsController < ApplicationController
  before_filter :authenticate_user!, :activation_required

  def create
    @report = current_user.reports.new(params[:report])
    @report.save ? redirect_to(show_report_path(@report)) : render(:action => :new)
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
end
