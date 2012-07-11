# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: zones
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  featured   :boolean         default(FALSE)
#

# An area where a teacher can teach. Can be a province, a town, a neighborhood, etc.
class Zone < ActiveRecord::Base
  
  has_many :classrooms, :dependent => :destroy
  has_and_belongs_to_many :contiguous_zones, :class_name => "Zone", :join_table => "contiguous_zones", :foreign_key => "zone_id", :association_foreign_key => "contiguous_zone_id"

  attr_accessible :name, :featured

  validates :name, :presence => true

  # Gets a complete list of contiguous zones for a list of zones returning a non-repeating array of zones
  #
  # @param zone_id_array [array] An array of zones ids
  # @return [Array] A list of zones that are contiguous to the received zones. It includes all the zones passed in the zones_array parameter
  def self.find_all_contiguous_zones(zone_id_array)
    
    contiguous_zones = []

    zone_id_array.each do |zone_id|

      zone = Zone.find(zone_id)

      contiguous_zones += [zone]
      contiguous_zones += zone.contiguous_zones
    end

    # Eliminate duplicates
    done = contiguous_zones.uniq!

    # return my array
    (contiguous_zones)
  end
  
end
