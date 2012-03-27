# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: activities
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Activity do

  before(:each) do
    @category = Factory(:category)
    @attr = {:name => "Music"}
  end

  it "should be able to create an Activity" do
    @category.activities.create!(@attr)
  end

  describe "validations" do

    before(:each) do
      @activity = @category.activities.create(@attr)
    end

    it "should require a name" do
      @activity.name = ""
      no_name_activity = @activity
      no_name_activity.should_not be_valid
    end

    it "should require a category" do
      @activity.category = nil
      no_category_activity = @activity
      no_category_activity.should_not be_valid
    end

  end

end
