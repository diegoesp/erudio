# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: zones
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Zone < ActiveRecord::Base
  has_many :classrooms, :dependent => :destroy

  attr_accessible :name, :featured

  validates :name, :presence => true
end
