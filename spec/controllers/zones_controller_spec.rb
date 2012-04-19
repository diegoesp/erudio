require 'spec_helper'

describe ZonesController do

  describe "contiguous_zones", :type => :api do

     before(:each) do
       @zone = Factory(:zone)
       @zone3 = Factory(:zone3)
     end

     it "call for Mataderos must get one result" do
       get "contiguous", :format => "json", :zone_id => @zone3.id
       response.status.should == 200
       zones = JSON.parse(response.body, :object_class => Zone)
       zones.length.should == 1
     end
     
     it "call for Villa Crespo should get no result" do
       get "contiguous", :format => "json", :zone_id => @zone.id
       response.status.should == 200
       zones = JSON.parse(response.body, :object_class => Zone)
       zones.length.should == 0
     end
     
   end
   
end
