# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  last_name          :string(255)
#  first_name         :string(255)
#  email              :string(255)
#  phone              :string(255)
#  description        :string(255)
#  avatar             :string(255)
#  publish_email      :boolean
#  publish_phone      :boolean
#  type               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do

  before(:each) do
    @user = Factory(:user)
  end

  it "should create a valid instance using factory girl" do
    @user.should be_valid
  end

  it "should require first name" do
    @user.first_name = ""
    @user.should_not be_valid
  end

  it "should require last name" do
    @user.last_name = ""
    @user.should_not be_valid
  end

  it "should require email" do
    @user.email = ""
    @user.should_not be_valid
  end

  it "should validate a valid email address" do
    @user.email = "diegoesp@gmail.com"
    @user.should be_valid
  end

  it "should not validate an invalid email address" do
    @user.email = "carlos@@prueba"
    @user.should_not be_valid
  end

  it "should not validate an invalid avatar image" do
    @user.avatar = "invalid_image.tif"
    @user.should_not be_valid
  end

  it "should accept an empty avatar image" do
    @user.avatar = nil
    @user.should be_valid
  end

  it "should not respond to teacher attributes publish_email, publish_phone and description" do
    @teacher.should_not respond_to(:publish_email, :publish_phone, :description)
  end

  describe "password validations" do

    it "should require a password" do
      @user.password = ""
      @user.password_confirmation = ""
      @user.should_not be_valid
    end

    it "should require a confirmation that matches the pasword" do
      @user.password_confirmation = "does_not_match"
      @user.should_not be_valid
    end

    it "should reject short passwords" do
      @user.password = "12345"
      @user.should_not be_valid
    end
  end

  describe "password encryption" do

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.password = "password"
        @user.has_password?("password").should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@user.email, "wrongpassword")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @user.password)
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@user.email, @user.password)
        matching_user.should == @user
      end

      it "should NOT authenticate via salt" do
        non_matching_user = User.authenticate_with_salt(@user.id, "INVALID SALT")
        non_matching_user.should be_nil
      end

      it "should authenticate via salt" do
        matching_user = User.authenticate_with_salt(@user.id, @user.salt)
        matching_user.should == @user
      end
    end

    describe "ratings" do

      it "should return the teacher is rated" do
        teacher = Factory(:teacher)

        @user.rate_a_teacher(teacher.id, 5, "a great teacher!")
        @user.has_rated_teacher?(teacher).should be_true
      end

      it "should return the teacher is NOT rated" do

        teacher = Factory(:teacher)
        teacher2 = Factory(:teacher2)

        @user.rate_a_teacher(teacher2.id, 1, "A bad teacher")
        @user.has_rated_teacher?(teacher).should be_false
      end

    end

  end
end
