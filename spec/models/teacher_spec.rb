# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: teachers
#
#  id          :integer         not null, primary key
#  last_name   :string(255)
#  first_name  :string(255)
#  description :string(255)
#  email       :string(255)
#  cellphone   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
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

end
