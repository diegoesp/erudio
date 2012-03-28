require "rspec"

describe SessionsController do

  describe "API testing", :type => :api do

    before(:each) do
      @user = Factory(:user)
    end

    it "should sign the user in" do
      get "api_login", :format => "json", :email => @user.email, :password => @user.password
      response.status.should == 200
      user = JSON.parse(response.body, :object_class => User)
      user.email.should == @user.email
      controller.should be_signed_in
    end

    it "should not let the user sign in" do
      get "api_login", :format => "json", :email => @user.email, :password => "invalid password"
      response.status.should == 200
      response.body.should == "null"
      controller.should_not be_signed_in
    end

    it "should sign in and sign out easily" do
      get "api_login", :format => "json", :email => @user.email, :password => @user.password
      controller.should be_signed_in
      get "api_logout", :format => "json"
      controller.should_not be_signed_in
    end

  end

end