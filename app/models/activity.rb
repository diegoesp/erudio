# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: activities
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  featured    :boolean         default(FALSE)
#

class Activity < ActiveRecord::Base
  belongs_to :category

  attr_accessible :name, :featured

  validates :name, :presence => true
  validates :category, :presence => true
end
