# == Schema Information
#
# Table name: zones
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Zone do

  before(:each) do
    @attr = {:name => "Almagro"}
  end

  it "should be able to create an instance with valid attributes" do
    Zone.create!(@attr)
  end

  it "should require name" do
    zone_without_name = Zone.create({:name => ""})
    zone_without_name.should_not be_valid
  end
end
