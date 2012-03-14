# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Category do

  before(:each) do
    @attr = {:name => "Music"}
  end

  it "should create an instance given these valid attributes" do
    Category.create!(@attr)
  end

  it "should require a name" do
    no_name_category = Category.new(@attr.merge(:name => ""))
    no_name_category.should_not be_valid
  end
end
