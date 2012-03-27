# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: classrooms
#
#  id                   :integer         not null, primary key
#  teacher_id           :integer
#  zone_id              :integer
#  goes_here            :boolean
#  receives_people_here :boolean
#  created_at           :datetime
#  updated_at           :datetime
#

class Classroom < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :zone

  validates :teacher, :presence => true
  validates :zone, :presence => true
  validates_inclusion_of :goes_here, :in => [true, false]
  validates_inclusion_of :receives_people_here, :in => [true, false]
end
