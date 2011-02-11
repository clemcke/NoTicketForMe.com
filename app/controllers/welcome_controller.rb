class WelcomeController < ApplicationController
  before_filter :authenticate_user!, :only => [:ten_commandments]
end
