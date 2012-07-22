# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  last_name          :string(255)
#  first_name         :string(255)
#  email              :string(255)
#  phone              :string(255)
#  description        :string(255)
#  avatar             :string(255)
#  publish_email      :boolean
#  publish_phone      :boolean
#  type               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe Teacher do

  before(:each) do
    @category = Factory(:category)
    @activity = Factory(:activity)
    @teacher = Factory(:teacher)
    @zone = Factory(:zone)
    @teacher.classrooms << Factory(:classroom, :teacher => @teacher, :zone => @zone)
    @teacher.professorships << Factory(:professorship3, :teacher => @teacher, :activity => @activity)
    
    @zone2 = Factory(:zone2)
    @teacher2 = Factory(:teacher2)
    @teacher2.classrooms << Factory(:classroom2, :teacher => @teacher2, :zone => @zone2)
    @teacher2.professorships << Factory(:professorship2, :teacher => @teacher2, :activity => @activity)
    
    @teacher3 = Factory(:teacher3)
    @teacher3.classrooms << Factory(:classroom3, :teacher => @teacher3, :zone => @zone)
    @teacher3.professorships << Factory(:professorship3, :teacher => @teacher3, :activity => @activity)
  end

  it "should be able to create an instance with valid attributes" do
    @teacher.should be_valid
  end

  it "should respond to attributes publish_email, publish_phone and description" do
    @teacher.should respond_to(:publish_email, :publish_phone, :description)
  end
  
  it "should validate factory girl instance" do
    @teacher.should be_valid
  end

  it "should require description" do
    @teacher.description = ""
    @teacher.should_not be_valid
  end

  it "find_teacher_for_pupil should return one teacher (Diego)" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone2.id], :receives_people_here => true
    teachers.length.should == 1
    teachers.first.first_name.should == "Diego"
  end

  it "find_teacher_for_pupil using phone should return Diego" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone2.id], :must_have_phone =>true
    teachers.first.first_name.should == "Diego"
  end

  it "find_teacher_for_pupil using email should return Diego" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone2.id], :must_have_email =>true
    teachers.first.first_name.should == "Diego"
  end

  it "find_teacher_for_pupil using maximum price should return Diego" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone2.id], :maximum_price_per_hour => 100
    teachers.first.first_name.should == "Diego"
  end

  it "find_teacher_for_pupil using order_by should return first Pacino and then Pochiero" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id], :order_by => "last_name"
    teachers.length.should == 2
    teachers.first.first_name.should == "Al"
  end

  it "calling find_teacher_for_pupil with only page_size and no page_number should return an error" do
    lambda do
      Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id], :page_size => 1
    end.should raise_error()
  end
  
  it "calling find_teacher_for_pupil with only page_number and no page_size should return an error" do
    lambda do
      Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id], :page_number => 1
    end.should raise_error()
  end
  
  it "find_teacher_for_pupil using @activity and @zone should return 2 records" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id]
    teachers.length.should == 2 
  end

  it "find_teacher_for_pupil using @activity and @zone and that must have price should return no records" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id], :must_have_price => true
    teachers.length.should == 0
  end
  
  it "find_teacher_for_pupil using page_size and page_number should return only one record" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id], :page_size => 1, :page_number => 1
    teachers.length.should == 1    
  end

  it "find_teacher_for_pupil using page_size 2 and page_number 1 should return two records" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id], :page_size => 2, :page_number => 1
    teachers.length.should == 2 
  end
  
  it "find_teacher_for_pupil using page_size 1 and page_number 2 should return only one record" do
    teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone.id], :page_size => 1, :page_number => 2
    teachers.length.should == 1
  end
  
  it "should return Villa Crespo and Palermo for teacher" do
    @teacher.classrooms << Factory(:classroom2, :teacher => @teacher, :zone => @zone2)
    @teacher.locations.should include("Palermo")
    @teacher.locations.should include("Villa Crespo")
  end

  it "should return that the teacher1 does not go to places to teach" do
    @teacher.goes_to_places.should be_false
  end
  it "should return that the teacher1 receives people at home to teach" do
    @teacher.receives_people.should be_true
  end

  describe "test rating system for teacher" do

    before(:each) do
      @user = Factory(:user)
      @user2 = Factory(:user2)
      @user3 = Factory(:user3)
    end

    it "should add three ratings 1,3 and 4 and average should be 8/3" do
      @teacher.ratings.create(:user_id => @user.id, :rating => 1, :comment => "This teacher really sucks")
      @teacher.ratings.create(:user_id => @user2.id, :rating => 3, :comment => "This teacher is average. Not that bad")
      @teacher.ratings.create(:user_id => @user3.id, :rating => 4, :comment => "He's a pretty good teacher!'")

      @teacher.get_rating().should == (8.to_f / 3.to_f)
    end

    it "should return zero when no ratings exists" do
      @teacher.get_rating().should == 0
    end
    
    it "should rate and then get the rating through the search" do
      @teacher2.ratings.create(:user_id => @user.id, :rating => 1, :comment => "This teacher really sucks")
      teachers = Teacher.find_teacher_for_pupil :activity_id => @activity.id, :zone_id_array => [@zone2.id], :receives_people_here => true
      teachers.length.should == 1      
      teachers.first.get_rating.should == 1
    end
    
  end
end
