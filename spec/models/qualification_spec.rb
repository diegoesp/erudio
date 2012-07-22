# == Schema Information
#
# Table name: qualifications
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  institute  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Qualification do
  
 	before(:each) do
 		@qualification = Factory(:qualification)
	end

	it "should validate a valid instance" do
		@qualification.should be_valid
	end

	it "should require the name" do
		@qualification.name = ""
		@qualification.should_not be_valid
	end

	it "should require the institute" do
		@qualification.institute = ""
		@qualification.should_not be_valid
	end
end