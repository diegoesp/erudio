# -*- encoding : utf-8 -*-
require 'spec_helper'

describe PagesController do

  render_views

  before(:each) do
    @category = Factory(:category)
    @activity = Factory(:activity)
    @zone = Factory(:zone)
    @zone3 = Factory(:zone3)
    @zone2 = @zone3.contiguous_zones.first    
  end

  describe "GET 'home'" do

    it "should be successful" do
    get :home
      response.should be_success
    end

    it "should include a json for a list of activities" do
      get :home
      activities = [@activity]
      response.should contain activities.to_json.to_s
    end
    
    it "should include a json for a list of zones ordered by name" do
      get :home
      zones = [@zone3, @zone2, @zone]             # Mataderos, Palermo, Villa Crespo
      response.should contain zones.to_json.to_s
    end
    
    it "should include a json for a list of featured zones ordered by name" do
      get :home
      zones = [@zone3, @zone]             # Mataderos, Villa Crespo
      response.should contain zones.to_json.to_s
    end
    
  end

  describe "API testing", :type => :api do

    before(:each) do
      @activity = Factory(:activity)
      @zone = Factory(:zone)
      @teacher = Factory(:teacher)
      @user = Factory(:user)
      @teacher.classrooms << Factory(:classroom, :teacher => @teacher, :zone => @zone)
      @teacher.professorships << Factory(:professorship, :teacher => @teacher, :activity => @activity)
      @teacher.ratings << Factory(:rating, :teacher => @teacher, :user => @user)
    end

    it "should call api_search_teachers and receive no result" do
      get "api_search_teachers", :format => "json", :activity_id => @activity.id, :zone_id_csv => @zone.id, :goes_here => "true"
      response.status.should == 200
      teachers = JSON.parse(response.body, :object_class => Teacher)
      teachers.length.should == 0
    end

    it "should call api_search_teachers and receive only one result: Octavio with rating 3" do
      get "api_search_teachers", :format => "json", :activity_id => @activity.id, :zone_id_csv => @zone.id
      response.status.should == 200
      teachers = JSON.parse(response.body, :object_class => Teacher)
      teachers.length.should == 1
      teachers.first.first_name.should == "Octavio"
      teachers.first.rating.should == 3
      response.body.should contain '"rating":3'
    end

    it "should return all activities for the teacher" do
      @activity2 = Factory(:activity2)
      @teacher.professorships << Factory(:professorship4, :teacher => @teacher, :activity => @activity2)
      get "api_search_teachers", :format => "json", :activity_id => @activity.id, :zone_id_csv => @zone.id
      response.status.should == 200
      response.body.should contain '"name":"Guitar"'
      response.body.should contain '"name":"Mathematics"'
    end

  end
end
