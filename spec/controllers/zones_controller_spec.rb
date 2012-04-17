require 'spec_helper'

describe ZonesController do

  describe "API testing", :type => :api do

     before(:each) do
       @zone = Factory(:zone)
       @zone3 = Factory(:zone3)
     end

     it "must api_get_continuous_zones for Mataderos and get one result" do
       get "api_get_contiguous_zones", :format => "json", :zone_id => @zone3.id
       response.status.should == 200
       zones = JSON.parse(response.body, :object_class => Zone)
       zones.length.should == 1
     end
     
     it "must api_get_continuous_zones for Villa Crespo and get no result" do
       get "api_get_contiguous_zones", :format => "json", :zone_id => @zone.id
       response.status.should == 200
       zones = JSON.parse(response.body, :object_class => Zone)
       zones.length.should == 0
     end
     
   end
   
end
