# -*- encoding : utf-8 -*-
# Controller that works with the Teacher resourece
class TeachersController < ApplicationController

  respond_to :html, :json
  skip_before_filter :require_login, :only => [:home, :search, :show, :rating]

  # Displays the homepage (that contains the wizard)
  def home
    @json_all_activities = Activity.all.to_json
    @json_featured_activities = Activity.find_all_by_featured(true).to_json
    @json_all_zones = Zone.find(:all, :order => "name").to_json
    @json_featured_zones = Zone.find_all_by_featured(true, :order => "name").to_json
  end
  
  # API for searching teachers in the wizard
  #
  # @param [String] activity_id activity id for the teacher to match
  # @param [String] zone_id_csv A comma separated values list of zone id for the teacher to match
  # @param [String] goes_here an OPTIONAL boolean string => if true, then the teacher must be able to go to the detailed zones to teach
  # @param [String] receives_people_here an OPTIONAL boolean string => if true, then the teacher must be able to receive people in the detailed zones to teach
  # @param [String] must_have_phone an OPTIONAL boolean string => if true, then the teacher must have a phone
  # @param [String] must_have_email an OPTIONAL boolean string => if true, then the teacher allowed erudio to publish his email
  # @param [String] maximum_price_per_hour an OPTIONAL integer => If provided, gets the maximum allowed price per teacher
  # @param [String] order_by an OPTIONAL string => If provided, it must be a field of the model. You can also order by the virtual attribute rating.
  # @param [String] page_size an OPTIONAL number => If supplied, the search will be paginated and this page_size will be used. If page_number is not supplied an exception will be thrown.
  # @param [String] page_number an OPTIONAL number => If supplied, must be the page required based on page_size. If page_size was not supplied, an exception will be thrown.
  # @return [String] A JSON string containing the teachers
  def search
    activity_id = params[:activity_id]
    zone_id_csv = params[:zone_id_csv]
    goes_here = params[:goes_here]
    receives_people_here = params[:receives_people_here]
    must_have_phone = params[:must_have_phone]
    must_have_email = params[:must_have_email]
    maximum_price_per_hour = params[:maximum_price_per_hour]
    order_by  = params[:order_by]
    page_size = params[:page_size]
    page_number = params[:page_number]
    
    raise "must specify activity_id parameter" unless !activity_id.nil?
    raise "must specify zone_id_csv parameter" unless !zone_id_csv.nil?
    
    # Check zone id array to be an array of integers 
    zone_id_array = zone_id_csv.split(",")
    zone_id_array.each do |zone_id|
      raise "each zone_id must be a number: " + zone_id unless zone_id.is_number?
    end
    
    # Check parameters
    raise "activity_id must be a number: #{activity_id} " unless activity_id.is_number?        
    raise "goes_here must be true/false: #{goes_here}" unless (goes_here.nil? or !goes_here.is_boolean?)
    raise "receives_people_here must be true/false: #{receives_people_here} " unless (receives_people_here.nil? or !receives_people_here.is_boolean?)
    raise "must_have_phone must be true/false: #{must_have_phone} " unless (must_have_phone.nil? or !must_have_phone.is_boolean?)
    raise "must_have_email must be true/false: #{must_have_email} " unless (must_have_email.nil? or !must_have_email.is_boolean?)
    raise "maximum_price_per_hour must be a number: #{maximum_price_per_hour} " unless (maximum_price_per_hour.nil? or !maximum_price_per_hour.is_number?)
    if !page_size.nil? 
      raise "page_size must be a number: #{page_size} " unless page_size.is_number?
    end
    if !page_number.nil? 
      raise "page_number must be a number: #{page_number} " unless page_number.is_number?
    end
    
    # Just for search_html.erb debugging purposes => DEPRECATED, should erase
    @json_result = '{"activity":"Teatro","description":"Lorem ipsum dolum","lastName":"Chiti","name":"Rafael","phone":"46595841","price":"$ 45","stars":"2","tags":["Musico","Rockstar"]},{"activity":"Guitarra","description":"Lorem ipsum dolum","lastName":"Espada","name":"Diego","phone":"46577654","price":"$ 65","stars":"3","tags":["Rockstar","Loquito lindo","Tag very very long"]},{"activity":"Piano","description":"Lorem ipsum dolum","lastName":"Pochiero","name":"Octavio","phone":"45678723","price":"$ 66","stars":"5","tags":["Piano"]},{"activity":"Saxo","description":"Lorem ipsum dolum","lastName":"Rodriguez","name":"Pedro","phone":"47656789","price":"$ 10","stars":"4","tags":["I dont know what to write", "asdasdasd","asdasdasdas","asdadasd"]}'
    
    @teachers = Teacher.find_teacher_for_pupil :activity_id => activity_id, :zone_id_array => zone_id_array, :goes_here => goes_here, :receives_people_here => receives_people_here, :must_have_phone => must_have_phone, :must_have_email => must_have_email, :maximum_price_per_hour => maximum_price_per_hour, :order_by => order_by, :page_size => page_size, :page_number => page_number    
    respond_with @teachers, :include => { :professorships => { :include => :activity }}
  end
  
  # Shows the detail page for the teacher. Used for displaying the teacher to a pupil
  # @param [Integer] id Teacher id to be shown
  # @return [String] a Teacher object serialized to JSON
  def show
    id = params[:id]

    raise "must specify id parameter" unless !id.nil?
    
    @teacher = Teacher.find(id)
    respond_with(@teacher)
  end

  # Allows the user currently logged to rate a teacher
  #
  # @param [Integer] id Teacher to be rated
  # @param [Integer] rating Rating, 1 to 5
  # @param [String] comment Comments for the rating
  # @return [String] A rating object serialized as JSON
  # @raise [Error] any validation error that happens to occur
  def rate
    id = params[:id]
    rating = params[:rating]
    comment = params[:comment]

    raise "must specify id parameter" unless !id.nil?
    raise "must specify rating parameter" unless !rating.nil?
    raise "must specify comment parameter" unless !comment.nil?

    rating = current_user.rate_a_teacher(id, rating, comment)

    respond_with(rating)
  end

  # Gets the rating of a teacher
  #
  # @param [Integer] id Teacher to be rated
  # @return [String] A simple JSON containing a string analogous to { rating = 3 }
  def rating
    id = params[:id]

    raise "must specify id parameter" unless !id.nil?
    raise "id must be a number" unless id.is_number?

    teacher = Teacher.find(id)

    respond_with(:rating => teacher.get_rating)
  end
  
end