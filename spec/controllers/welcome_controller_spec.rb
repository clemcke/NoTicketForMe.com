require 'spec_helper'

describe WelcomeController do
  it "should successfully render the home page" do
    get 'index'
  end
end
