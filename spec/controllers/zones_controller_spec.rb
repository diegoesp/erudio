require 'spec_helper'

describe ZonesController do

  describe "contiguous_zones", :type => :api do

     before(:each) do
       @zone = Factory(:zone)
       @zone3 = Factory(:zone3)
       @zone3.contiguous_zones << @zone
     end

     it "call for Mataderos must get one result" do
       get "contiguous", :format => "json", :id => @zone3.id
       response.status.should equal 200
       zones = JSON.parse(response.body, :object_class => Zone)
       zones.length.should eq 1
     end
     
     it "call for Villa Crespo should get no result" do
       get "contiguous", :format => "json", :id => @zone.id
       response.status.should equal 200
       zones = JSON.parse(response.body, :object_class => Zone)
       zones.length.should eq 0
     end
     
   end
   
end
