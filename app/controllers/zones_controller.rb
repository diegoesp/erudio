# -*- encoding : utf-8 -*-
# Controller that provides general APIs for Zones
class ZonesController < ApplicationController
  
  respond_to :json
  skip_before_filter :require_login, :only => [:contiguous]
  
  # Gets the contiguous zones for a given zone
  #
  # @param [String] zone_id Zone for whom we're getting the contiguous zones
  # @return [String] JSON with a list zones that are contiguous to this zone
  def contiguous

    zone_id = params[:zone_id]    
    raise "must specify zone_id parameter" unless !zone_id.nil?
    
    contiguous_zones = Zone.find(zone_id).contiguous_zones
    respond_with(contiguous_zones)
  end

end
