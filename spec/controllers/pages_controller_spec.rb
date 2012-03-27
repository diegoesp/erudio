# -*- encoding : utf-8 -*-
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
      response.should contain @activities.to_json.to_s
    end
  end

  describe "API testing", :type => :api do

    before(:each) do
      @activity = Factory(:activity)
      @zone = Factory(:zone)
      @teacher = Factory(:teacher)
      @teacher.classrooms << Factory(:classroom, :teacher => @teacher, :zone => @zone)
      @teacher.professorships << Factory(:professorship, :teacher => @teacher, :activity => @activity)
    end

    it "should call api_search_teachers and receive no result" do
          get "api_search_teachers", :format => "json", :activity_id => @activity.id, :zone_id => @zone.id, :goes_here => "true"
          response.status.should == 200
          teachers = JSON.parse(response.body, :object_class => Teacher)
          teachers.length.should == 0
    end

    it "should call api_search_teachers and receive only one result: Octavio" do
      get "api_search_teachers", :format => "json", :activity_id => @activity.id, :zone_id => @zone.id
      response.status.should == 200
      teachers = JSON.parse(response.body, :object_class => Teacher)
      teachers.length.should == 1
      teachers.first.first_name.should == "Octavio"
    end

  end
end
