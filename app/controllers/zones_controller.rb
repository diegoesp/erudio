# -*- encoding : utf-8 -*-
# Controller that provides general APIs for Zones
class ZonesController < ApplicationController
  
  respond_to :json
  skip_before_filter :require_login, :only => [:contiguous]
  
  # Gets the contiguous zones for a given zone
  #
  # @param [String] id Zone id for whom we're getting the contiguous zones
  # @return [String] JSON with a list zones that are contiguous to this zone
  def contiguous

    id = params[:id]    
    raise "must specify id parameter" unless !id.nil?
    
    contiguous_zones = Zone.find(id).contiguous_zones
    respond_with(contiguous_zones)
  end
  
end
