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
	# @param [Array] zone_id_array a list of zones id where a teacher can teach
	# @param [Boolean] goes_here optional. If true, the teacher can go to any of these zones
	# @param [Boolean] receives_people_here optional. If true, the teacher can receive people in any of these zones at home
	# @param [Boolean] must_have_phone optional. If true, the teacher must have phone
	# @param [Boolean] must_have_email optional. If true, the teacher must be willing to disclose his e-mail.
	# @param [Integer] maximum_price_hour optional. The top price for the teachers to be listed
	# @param [String] order_by optional. A field name to be used for order as  DESC
	# @param [Integer] page_size optional. If specified, the search will be paged and this page size will be used
	# @param [Integer] page_number optional. If specified, the search will be paged and this page number will be returned
	# @return [Array] Teacher arrays
	def self.find_teacher_for_pupil(activity_id, zone_id_array, goes_here = nil, receives_people_here = nil, must_have_phone = nil, must_have_email = nil,  maximum_price_hour = nil, order_by = nil, page_size = nil, page_number = nil)

    zone_id_string = zone_id_array.join(",")
    goes_here_string = (goes_here ? "t" : "f")
    receives_people_here_string = (receives_people_here ? "t" : "f")
    
    sql = "SELECT users.*, ratings_per_teacher.teacher_rating AS rating"
    sql += " FROM users"
    sql += " INNER JOIN professorships ON professorships.teacher_id = users.id"
    sql += " INNER JOIN classrooms ON classrooms.teacher_id = users.id"
    sql += " LEFT OUTER JOIN (SELECT teacher_id, AVG(rating) as teacher_rating FROM ratings) AS ratings_per_teacher ON ratings_per_teacher.teacher_id = users.id"
    sql += " WHERE"
		sql += " goes_here = '#{goes_here_string}' AND" unless goes_here.nil?
		sql += " receives_people_here = '#{receives_people_here_string}' AND" unless receives_people_here.nil?
		sql += " professorships.activity_id = #{activity_id} AND"
		sql += " classrooms.zone_id IN (#{zone_id_string}) AND"
    sql += " users.type = 'Teacher'"
    
		Teacher.find_by_sql(sql)
  end

  # Gets the average rating of a teacher. If the teacher has no ratings yet, zero is returned.
  # If the find_teacher_for_pupil searcher was executed, the rating is cached, so the N+1 query problem is avoided.
  # 
  # @return [Float] and average rating indicator
  def get_rating()

    cached_rating = self.attributes['rating']
    return cached_rating unless cached_rating.nil?
    
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
