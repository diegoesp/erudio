# -*- encoding : utf-8 -*-
require 'spec_helper'

describe TeachersController do

  render_views

  before(:each) do
    @category = Factory(:category)
    @activity = Factory(:activity)
    @zone = Factory(:zone)
    @zone3 = Factory(:zone3)
    @zone2 = Factory(:zone2)
    @teacher = Factory(:teacher)
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

  describe "search API", :type => :api do

    before(:each) do
      @activity = Factory(:activity)
      @zone = Factory(:zone)
      @user = Factory(:user)
      @teacher.classrooms << Factory(:classroom, :teacher => @teacher, :zone => @zone)
      @teacher.professorships << Factory(:professorship, :teacher => @teacher, :activity => @activity)
      @teacher.ratings << Factory(:rating, :teacher => @teacher, :user => @user)
    end

    it "must return an error because i'm using page_size without page_number" do
      get "search", :format => "json", :activity_id => @activity.id, :zone_id_csv => @zone.id, :goes_here => "true", :page_size => "invalid"
      response.status.should equal 406
      response.body.should contain "page_size must be a number"
    end

    it "should call search and receive no result" do
      get "search", :format => "json", :activity_id => @activity.id, :zone_id_csv => @zone.id, :goes_here => "true"
      response.status.should equal 200
      teachers = JSON.parse(response.body, :object_class => Teacher)
      teachers.length.should equal 0
    end

    it "should call search and receive only one result: Octavio with rating 3" do
      get "search", :format => "json", :activity_id => @activity.id, :zone_id_csv => @zone.id
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
      get "search", :format => "json", :activity_id => @activity.id, :zone_id_csv => @zone.id
      response.status.should == 200
      response.body.should contain '"name":"Guitar"'
      response.body.should contain '"name":"Mathematics"'
    end
  end

  describe "Rating API test", :type => :api do

    before(:each) do
      @user = Factory(:user)
    end

    it "should raise an error because i'm not authenticated'" do
      get "rate", :format => "json", :id => @teacher.id, :rating => 2, :comment => "A questionable quality teacher"
      response.status.should == 406
      response.body.should contain "user must be logged to execute this action"
    end

    describe "authenticated tests" do

      before(:each) do
        test_sign_in(@user)
      end

      it "should rate the teacher" do
        get "rate", :format => "json", :id => @teacher.id, :rating => 2, :comment => "A questionable quality teacher"
        response.status.should == 200
        rating = JSON.parse(response.body, :object_class => Rating)
        rating.teacher.id.should == @teacher.id
      end

    end

    it "should return the rating of a teacher'" do

      get "rating", :format => "json", :id => @teacher.id
      response.status.should == 200
      json = JSON.generate(:rating => 0)
      response.body.should == json.to_s
    end  
  
  end

  describe "Detail API test", :type => :api do

    it "must return a valid teacher" do

      get :show, :format => "json", :id => @teacher.id
      response.status.should eq 200
      response.body.should contain "Pochiero"
    end

  end

end
