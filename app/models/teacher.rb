# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  last_name          :string(255)
#  first_name         :string(255)
#  email              :string(255)
#  cellphone          :string(255)
#  description        :string(255)
#  type               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

class Teacher < User
	has_many :classrooms
	has_many :professorships, :dependent => :destroy
  has_many :ratings, :dependent => :destroy

	validates :description, :presence => true

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

  # Gets the average rating of a teacher. If the teacher has no ratings yet, zero is returned
  #
  # @return [Float] and average rating indicator
  def get_rating()

    rating_sum = 0
    i = 0

    # If there are no ratings
    if self.ratings.length == 0
      return 0
    end

    self.ratings.each do |rating|
      i = i + 1
      rating_sum += rating.rating.to_f
    end

    (rating_sum / i.to_f)
  end
end
