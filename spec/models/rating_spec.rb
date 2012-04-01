# == Schema Information
#
# Table name: ratings
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  teacher_id :integer
#  rating     :integer
#  comment    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Rating do

  before(:each) do
    @user = Factory(:user)
    @teacher = Factory(:teacher)
    @attr = {:teacher_id => @teacher.id, :rating => 2, :comment => "A lousy teacher with no enthusiasm"}
    @rating = @user.ratings.build(@attr)
  end

  it "should be a valid instance" do
    @rating.should be_valid
  end

  it "should require teacher" do
    @rating.teacher_id = nil
    @rating.should_not be_valid
  end

  it "should require user" do
    @rating.user_id = nil
    @rating.should_not be_valid
  end

  it "should require ratings to be greater than 0" do
    @rating.rating = 0
    @rating.should_not be_valid
  end

  it "should require ratings be less than 6" do
    @rating.rating = 6
    @rating.should_not be_valid
  end

  it "should require rating" do
    @rating.rating = nil
    @rating.should_not be_valid
  end

  it "should require comments" do
    @rating.comment = ""
    @rating.should_not be_valid
    @rating.comment = nil
    @rating.should_not be_valid
  end

  it "should require comments to be less than 256" do
    @rating.comment = ("a" * 270)
    @rating.should_not be_valid
  end

  it "should not allow a user to post more than one rating for a teacher" do

    lambda do
      @attr = {:teacher_id => @teacher.id, :rating => 3, :comment => "A second rating for the same teacher and the same user"}
      @user.ratings.build!(@attr)
    end.should raise_error()

  end

end
