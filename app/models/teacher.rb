# -*- encoding : utf-8 -*-
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

# A User that can teach to other Users
class Teacher < User
  has_many :classrooms
  has_many :professorships, :dependent => :destroy
  has_many :ratings, :dependent => :destroy

  validates :description, :presence => true
  
  attr_accessible :publish_email, :publish_phone, :description
  
  # Looks teachers for a pupil given his preferences
  #
  # @param [Hash] a hash that accepts the following symbols:
  # @param :activity_id Mandatory. Integer. Activity for the teacher
  # @param :zone_id_array Mandatory. Array. A list of zones id where a teacher can teach
  # @param :goes_here Optional. Boolean. If true, the teacher can go to any of these zones
  # @param :receives_people_here Optional. Boolean. If true, the teacher can receive people in any of these zones at home
  # @param :must_have_phone Optional. Boolean. If true, the teacher must have phone
  # @param :must_have_email Optional. Boolean. If true, the teacher must be willing to disclose his e-mail.
  # @param :must_have_price Optional. Boolean. If true, the teacher must have input price in his classes
  # @param :maximum_price_per_hour Optional. Integer. The top price for the teachers to be listed
  # @param :order_by Optional. String. A field name to be used for order as  DESC
  # @param :page_size Optional. Integer. If specified, the search will be paged and this page size will be used
  # @param :page_number Optional. Integer. If specified, the search will be paged and this page number will be returned
  # @return [Array] Teacher arrays
  def self.find_teacher_for_pupil(hsh)

    zone_id_string = hsh[:zone_id_array].join(",")
    goes_here_string = hsh[:goes_here] ? "t" : "f"
    receives_people_here_string = hsh[:receives_people_here] ? "t" : "f"
    must_have_phone = hsh[:must_have_phone] ? "t" : "f"
    must_have_email = hsh[:must_have_email] ? "t" : "f"
    must_have_price = hsh[:must_have_price] ? "t" : "f"
    # must provide both pagers parameters at the same time or none at all
    page_size = hsh[:page_size]
    page_number = hsh[:page_number]
    if (!page_size.nil? and page_number.nil?) or (page_size.nil? and !page_number.nil?)
      raise "must provide both page_size and page_number parameters or none of them"
    end
    # Take the values provided  
    unless page_size.nil?
      limit = page_size 
      offset = page_size * (page_number - 1)
    end
    
    sql = "SELECT users.*, ratings_per_teacher.teacher_rating AS rating"
    sql += " FROM users"
    sql += " INNER JOIN professorships ON professorships.teacher_id = users.id"
    sql += " INNER JOIN classrooms ON classrooms.teacher_id = users.id"
    sql += " LEFT OUTER JOIN (SELECT teacher_id, AVG(rating) as teacher_rating FROM ratings GROUP BY teacher_id) AS ratings_per_teacher ON ratings_per_teacher.teacher_id = users.id"
    sql += " WHERE"
    sql += " goes_here = '#{goes_here_string}' AND" unless hsh[:goes_here].nil?
    sql += " receives_people_here = '#{receives_people_here_string}' AND" unless hsh[:receives_people_here].nil?
    sql += " professorships.activity_id = #{hsh[:activity_id]} AND"
    sql += " classrooms.zone_id IN (#{zone_id_string}) AND"
    sql += " (publish_phone = 't' AND phone IS NOT NULL) AND" unless (must_have_phone.nil? or must_have_phone == "f")
    sql += " publish_email = 't' AND" unless (must_have_email.nil? or must_have_email == "f") 
    sql += " professorships.price_per_hour IS NOT NULL AND" unless (must_have_price.nil? or must_have_price == "f") 
    sql += " professorships.price_per_hour < #{hsh[:maximum_price_per_hour]} AND" unless hsh[:maximum_price_per_hour].nil?
    sql += " users.type = 'Teacher'"
    sql += " ORDER BY #{hsh[:order_by]}" unless hsh[:order_by].nil? 
    sql += " LIMIT #{limit} OFFSET #{offset}" unless page_size.nil?
    
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

  # Gets a String array with the locations that the teacher can reach, no matter if it is going there
  # or receiving people there. An appropriate alias for this method would be "area_of_influence"
  # @return [Array] of strings with the list of zones
  def locations()
    locations_array = [];

    self.classrooms.each do |classroom|
      locations_array << classroom.zone.name      
    end

    locations_array
  end

  # If true, then this teacher goes to places to teach
  # @return [Boolean] 
  def goes_to_places()    
    self.classrooms.each do |classroom|
      if classroom.goes_here 
        return true
      end
    end

    false
  end

  def receives_people()
    self.classrooms.each do |classroom|
      if classroom.receives_people_here 
        return true
      end
    end

    false
  end

end
