# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: classrooms
#
#  id                   :integer         not null, primary key
#  teacher_id           :integer
#  zone_id              :integer
#  goes_here            :boolean
#  receives_people_here :boolean
#  created_at           :datetime
#  updated_at           :datetime
#

require 'spec_helper'

describe Classroom do

  before(:each) do
    @teacher = Factory(:teacher)
    @zone = Factory(:zone)

    @attr = {:zone_id => @zone.id, :goes_here => false, :receives_people_here => true }
    @classroom = @teacher.classrooms.build(@attr)
  end

  it "should be able to create an instance with valid attributes" do
    @classroom.save!
  end

  it "should not be valid without specifying if it goes here" do
    @classroom.goes_here = nil
    @classroom.should_not be_valid
  end

  it "should not be valid without specifying if it receives people here" do
    @classroom.receives_people_here = nil
    @classroom.should_not be_valid
  end

end
