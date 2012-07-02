# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: zones
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  featured   :boolean         default(FALSE)
#

require 'spec_helper'

describe Zone do

  before(:each) do
    @zone = Factory(:zone)
    @zone2 = Factory(:zone2)
    @zone3 = Factory(:zone3)
    @zone3 = Factory(:zone4)
    @zone3.contiguous_zones << @zone2
    @zone2.contiguous_zones << @zone
  end

  it "should be able to create an instance with valid attributes" do
    Zone.create!({:name => "Almagro"})
  end

  it "should require name" do
    zone_without_name = Zone.create({:name => ""})
    zone_without_name.should_not be_valid
  end
  
  it "must include only the contiguous zone for Villa Crespo" do
    @zone3.contiguous_zones.length.should equal 1
    @zone3.contiguous_zones.first.name.should eq "Palermo"
  end

  it "should be equal to another zone with the same id" do
    zone5 = Zone.create!({:name => "Zone5"})
    zone6 = Zone.create!({:name => "Zone6"})

    zone6.should_not be_eql(zone5)

    zone6.id = zone5.id

    zone6.should be_eql(zone5)
    zone6.name.should_not be_eql(zone5.name)
  end

  it "search for all contiguous zones for a list of zones with no duplicates" do
    contiguous_zones = Zone.find_all_contiguous_zones([@zone2.id, @zone3.id])

    contiguous_zones.length.should eq 3
    contiguous_zones.should include(@zone2)
    contiguous_zones.should include(@zone3)
    contiguous_zones.should include(@zone)
    contiguous_zones.should_not include(@zone4)
  end

end