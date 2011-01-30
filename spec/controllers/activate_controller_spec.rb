require 'spec_helper'

describe ActivateController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'in_progress'" do
    it "should be successful" do
      get 'in_progress'
      response.should be_success
    end
  end

end
