class ZonesController < ApplicationController
  
  skip_before_filter :require_login, :only => [:api_get_contiguous_zones]
  
  # Gets the contiguous zones for a given zone
  #
  # @param [String] zone_id Zone for whom we're getting the contiguous zones
  # @return [String] JSON with a list zones that are contiguous to this zone
  def api_get_contiguous_zones

    zone_id = params[:zone_id]    
    raise "must specify zone_id parameter" unless !zone_id.nil?
    
    contiguous_zones = Zone.find(zone_id).contiguous_zones
    respond_with(contiguous_zones)
  end

end
