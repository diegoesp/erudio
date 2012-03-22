class PagesController < ApplicationController

  protect_from_forgery

  respond_to :json

  def home
    @json_init = Activity.all.as_json.to_s.html_safe
  end

  def api_search_teachers
    activity_id = params[:activity_id]
    zone_id = params[:zone_id]
    goes_here = params[:goes_here]
    receives_people_here = params[:receives_people_here]

    raise "must specify activity_id parameter" unless !activity_id.nil?
    raise "must specify zone_id parameter" unless !zone_id.nil?

    raise "activity_id must be a number: " + activity_id unless activity_id.is_number?
    raise "zone_id must be a number: " + zone_id unless zone_id.is_number?
    raise "goes_here must be true/false: " + goes_here unless (goes_here.nil? or !goes_here.is_boolean?)
    raise "receives_people_here must be true/false: " + receives_people_here unless (receives_people_here.nil? or !receives_people_here.is_boolean?)

    teachers = Teacher.find_teacher_for_pupil(activity_id, zone_id, goes_here, receives_people_here)

    respond_with(teachers)
  end

end