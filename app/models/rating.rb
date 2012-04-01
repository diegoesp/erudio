# == Schema Information
#
# Table name: ratings
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  teacher_id :integer
#  rating     :integer
#  comment    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# A user can rate a Teacher appending a comment to that rating
class Rating < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :user

  attr_accessible :rating, :comment, :teacher_id, :user_id

  validates :teacher, :presence => true
  validates :user, :presence => true
  validates_uniqueness_of :teacher_id, :scope => :user_id
  validates :rating, :presence => true, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 5 }
  validates :comment, :presence => true, :length => { :maximum => 255 }
end
