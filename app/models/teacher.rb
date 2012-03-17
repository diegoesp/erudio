# == Schema Information
#
# Table name: teachers
#
#  id          :integer         not null, primary key
#  last_name   :string(255)
#  first_name  :string(255)
#  description :string(255)
#  email       :string(255)
#  cellphone   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'valid_email'

class Teacher < ActiveRecord::Base
  has_many :classrooms
  has_many :professorships, :dependent => :destroy

  attr_accessible :last_name, :first_name, :description, :email, :cellphone

  validates :last_name, :presence => true
  validates :first_name, :presence => true
  validates :description, :presence => true
  validates :email, :presence => true, :email => true
end
