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
end
