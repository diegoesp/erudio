class PagesController < ApplicationController

  protect_from_forgery

  respond_to :json

  def home
    @json_init = Activity.all.as_json.to_s.html_safe
  end

  def api_search_teachers
    activity_id = params[:category_id]
    zone_id = params[:town_id]
    goes_here = params[:goes_here]
    receives_people_here = params[:receives_people_here]

    raise "activity_id must be a number" unless activity_id.is_number?
    raise "zone_id must be a number" unless zone_id.is_number?
    raise "goes_here must be true/false" unless (zone_id == "" or zone_id.is_boolean?)
    raise "receives_people_here must be true/false" unless (receives_people_here == "" or receives_people_here.is_boolean?)

    respond_with(@json_result)
  end

end