require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @category = Factory(:category)
    @activity = Factory(:activity)
  end

  describe "GET 'home'" do

    it "should be successful" do
    get :home
      response.should be_success
    end

    it "should include a json for a list of activities" do
      get :home
      @activities = [@activity]
      response.should have_selector("input#json_init", :value => @activities.as_json.to_s)
    end
  end

end
