class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :activate_if_new

  private
  def activate_if_new
    if user_signed_in? && current_user.activation.status == "new" && !(params[:controller] == "activate" && params[:action] == "new")
      redirect_to "/activate/new"
    end
  end
end
