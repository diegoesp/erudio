require "rspec"

describe UsersController do

  before(:each) do
    @user = Factory(:user)
    @teacher = Factory(:teacher)
  end

  describe "API testing", :type => :api do

    it "should raise an error because i'm not authenticated'" do
      get "api_rate_a_teacher", :format => "json", :teacher_id => @teacher.id, :rating => 2, :comment => "A questionable quality teacher"
      response.status.should == 406
      json_data = JSON.parse(response.body, :object_class => Hash)
      json_data["message"].should == "a user must be logged to rate a teacher"
    end

    describe "authenticated tests" do

      before(:each) do
        test_sign_in(@user)
      end

      it "should rate the teacher" do
        get "api_rate_a_teacher", :format => "json", :teacher_id => @teacher.id, :rating => 2, :comment => "A questionable quality teacher"
        response.status.should == 200
        rating = JSON.parse(response.body, :object_class => Rating)
        rating.teacher.id.should == @teacher.id
      end

    end

    it "should return the rating of a teacher'" do

      get "api_get_teacher_rating", :format => "json", :teacher_id => @teacher.id
      response.status.should == 200
      json = JSON.generate(:rating => 0)
      response.body.should == json.to_s
    end


  end

end