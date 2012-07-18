# == Schema Information
#
# Table name: qualifications
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  institute  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Qualification < ActiveRecord::Base

	validates :name, :presence => true, :length => { :maximum => 80 }
	validates :institute, :presence => true, :length => { :maximum => 80 }
	
end
