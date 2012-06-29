# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: professorships
#
#  id             :integer         not null, primary key
#  teacher_id     :integer
#  activity_id    :integer
#  price_per_hour :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Professorship < ActiveRecord::Base
  belongs_to :activity
  belongs_to :teacher

  validates :teacher, :presence => true
  validates :activity, :presence => true

  validates :price_per_hour, :allow_nil => true, :numericality => { :less_than => 1000 }
end
