# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :activities

  attr_accessible :name

  validates :name, :presence => true
end
