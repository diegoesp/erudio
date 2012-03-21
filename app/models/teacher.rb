# == Schema Information
#
# Table name: teachers
#
#  id          :integer         not null, primary key
#  last_name   :string(255)
#  first_name  :string(255)
#  description :string(255)
#  email       :string(255)
#  cellphone   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'valid_email'

class Teacher < ActiveRecord::Base
  has_many :classrooms
  has_many :professorships, :dependent => :destroy

  attr_accessible :last_name, :first_name, :description, :email, :cellphone

  validates :last_name, :presence => true
  validates :first_name, :presence => true
  validates :description, :presence => true
  validates :email, :presence => true, :email => true

  # Looks teachers for a pupil given his preferences
  #
  # @param [Integer] activity_id Activity for the teacher
  # @param [Integer] zone_id zone where the teacher can teach
  # @param [Boolean] goes_here optional. If true, the teacher can go to this zone
  # @param [Boolean] receives_people_here optional. If true, the teacher can receive people in this zone at home
  # @return [Array] Teacher arrays
  def self.find_teacher_for_pupil(activity_id, zone_id, goes_here = nil, receives_people_here = nil)

    where = "professorships.activity_id = :activity_id AND classrooms.zone_id = :zone_id"

    where += " AND goes_here = :goes_here" unless goes_here.nil?
    where += " AND receives_people_here = :receives_people_here" unless receives_people_here.nil?

    Teacher.joins(:professorships).joins(:classrooms).where(where, :activity_id => activity_id, :zone_id => zone_id, :goes_here => goes_here, :receives_people_here => receives_people_here)
  end
end
