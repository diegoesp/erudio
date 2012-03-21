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
    @teacher2.professorships << Factory(:professorship2, :teacher => @teacher2)
  end

  it "should be able to create an instance with valid attributes" do
    @attr = {:last_name => "Chiti", :first_name => "Rafael", :description => "An outstanding programmer with excellent interpersonal skills and no contemplation for humanity. A really really bad person", :email => "rafaelchiti@gmail.com"}
    Teacher.create!(@attr)
  end

  it "should validate factory girl instance" do
    @teacher.should be_valid
  end

  it "should require first name" do
    @teacher.first_name = ""
    @teacher.should_not be_valid
  end

  it "should require last name" do
    @teacher.last_name = ""
    @teacher.should_not be_valid
  end

  it "should require description" do
    @teacher.description = ""
    @teacher.should_not be_valid
  end

  it "should require email" do
    @teacher.email = ""
    @teacher.should_not be_valid
  end

  it "should validate a valid email address" do
    @teacher.email = "diegoesp@gmail.com"
    @teacher.should be_valid
  end

  it "should not validate an invalid email address" do
    @teacher.email = "carlos@@prueba"
    @teacher.should_not be_valid
  end

  describe "finders" do

    before (:each) do
      puts Teacher.all.to_json
    end

    it "should return one teacher (Octavio)" do
      teachers = Teacher.find_teacher_for_pupil(@activity.id, @zone2.id, nil, nil)
      teachers.length.should == 1
      teacher = teachers[0]
      teacher.first_name.should_be "Octavio"
    end

  end

end
