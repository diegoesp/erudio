# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: professorships
#
#  id             :integer         not null, primary key
#  teacher_id     :integer
#  activity_id    :integer
#  price_per_hour :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Professorship do

  before(:each) do
    @teacher = Factory(:teacher)
    @activity = Factory(:activity)

    @attr = {:activity_id => @activity.id, :price_per_hour => 50}
    @professorship = @teacher.professorships.build(@attr)
  end

  it "should be valid" do
    @professorship.should be_valid
  end

  it "should be able to create an instance with valid attributes" do
    @professorship.save!
  end

  it "should delete all professorships in case I delete a teacher" do
    @teacher.save!
    @professorship.save!

    @teacher.destroy
    professorship = Professorship.find_by_id(@professorship.id)
    professorship.should be_nil
  end

  it "should require the price" do
    @professorship.price_per_hour = nil
    @professorship.should_not be_valid
  end

end
