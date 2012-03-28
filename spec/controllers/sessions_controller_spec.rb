require "rspec"

describe SessionsController do

	describe "API testing", :type => :api do

		before(:each) do
			@user = Factory(:user)
		end

		it "should login" do
			get "api_login", :format => "json", :email => @user.email, :password => @user.password
			response.status.should == 200
			teachers = JSON.parse(response.body, :object_class => Teacher)
			teachers.length.should == 0
		end

	end

end