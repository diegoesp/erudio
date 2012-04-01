# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  last_name          :string(255)
#  first_name         :string(255)
#  email              :string(255)
#  cellphone          :string(255)
#  description        :string(255)
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

    @zone2 = Factory(:zone2)
    @teacher2 = Factory(:teacher2)
    @teacher2.classrooms << Factory(:classroom2, :teacher => @teacher2, :zone => @zone2)
    @teacher2.professorships << Factory(:professorship2, :teacher => @teacher2, :activity => @activity)
  end

  it "should be able to create an instance with valid attributes" do
    @teacher.should be_valid
  end

  it "should validate factory girl instance" do
    @teacher.should be_valid
  end

  it "should require description" do
    @teacher.description = ""
    @teacher.should_not be_valid
  end

  it "find_teacher_for_pupil should return one teacher (Diego)" do
    teachers = Teacher.find_teacher_for_pupil(@activity.id, @zone2.id, nil, true)
    teachers.length.should == 1
    teachers.first.first_name.should == "Diego"
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

  end
end
