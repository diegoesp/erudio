# -*- encoding : utf-8 -*-
class PagesController < ApplicationController

  protect_from_forgery

  respond_to :json

  # Displays the homepage
  def home
    @json_all_activities = Activity.all.to_json
    @json_featured_activities = Activity.find_all_by_featured(true).to_json
  end

  # API for searching teachers
  #
  # @param [String] activity_id activity id for the teacher to match
  # @param [String] zone_id zone id for the teacher to match
  # @param [String] goes_here a boolean string
  # @param [String] receives_people_here a boolean string
  # @return [String] JSON with a list of teachers
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
