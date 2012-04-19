require "rspec"

describe UsersController do

  describe "User session management API", :type => :api do

    before(:each) do
      @user = Factory(:user)
    end

    it "should sign this valid user in" do
      get "login", :format => "json", :email => @user.email, :password => @user.password
      response.status.should == 200
      user = JSON.parse(response.body, :object_class => User)
      user.email.should == @user.email
      controller.should be_signed_in
    end

    it "should not let the user sign in when the password is invalid" do
      get "login", :format => "json", :email => @user.email, :password => "invalid password"
      response.status.should == 200
      response.body.should == "null"
      controller.should_not be_signed_in
    end

    it "should sign in and sign out easily" do
      get "login", :format => "json", :email => @user.email, :password => @user.password
      controller.should be_signed_in
      get "logout", :format => "json"
      controller.should_not be_signed_in
    end

  end

end