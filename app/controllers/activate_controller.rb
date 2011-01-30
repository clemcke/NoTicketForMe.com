class ActivateController < ApplicationController
  before_filter :authenticate_user!

  def new
    current_user.activation.set_status_as_in_progress!
  end

  def in_progress
  end

  def reset
    unless current_user.activated?
      current_user.activation.set_status_as_new!
      redirect_to activate_new_path
    else
      redirect_to root_url
    end
  end

end
