# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  last_name          :string(255)
#  first_name         :string(255)
#  email              :string(255)
#  cellphone          :string(255)
#  description        :string(255)
#  type               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

class User < ActiveRecord::Base

  require 'valid_email'

  attr_accessor :password
  attr_accessible :last_name, :first_name, :description, :email, :cellphone, :password, :password_confirmation, :avatar

  validates :last_name, :presence => true
  validates :first_name, :presence => true
  validates :email, :presence => true, :email => true
  validates :password, :confirmation => true, :presence => true, :length => {:minimum => 5}
  validates :avatar,  :format => { :allow_nil => true, :with => /[\w\d\-_]*\.(jpg|gif|png)/ }, :length => { :maximum => 255 }
  before_save :encrypt_password

  has_many :ratings, :dependent => :destroy

  # Return true if the user's password matches the submitted password
  #
  # @param [String] submitted_password Password to be checked
  # @return [Boolean] true if the password matches
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  # Authenticates the user into the system
  #
  # @param [String] email Email to be authenticated
  # @param [String] submitted_password Tries this password against the user password
  # @return [User] If the authentication succeeds, returns the user authenticated. If not, returns nil
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  # Allows to authenticate using a User id and a salt. This method is specifically thought for a cookie auth
  #
  # @param [Integer] id User id
  # @param [String] cookie_salt Salt password
  # @return [User] If the authentication succeeds, returns the user authenticated. If not, returns nil
  def self.authenticate_with_salt(id, salt)
    user = find_by_id(id)
    (user && user.salt == salt) ? user : nil
  end

  # Present user rates a given teacher
  #
  # @param [Integer] a Teacher id to rate
  # @param [Integer] a Rating, from 1 to 5
  # @param [String] a comment for the rating
  # @return [Rating] The rating just created
  # @raise [Error] an error if any of the validations fail when creating the rating
  def rate_a_teacher(teacher_id, rating, comment)
    @attr = {:teacher_id => teacher_id, :rating => rating, :comment => comment}
    self.ratings.create!(@attr)
  end

  # True if the user has rated a given teacher
  #
  # @param [Teacher] a teacher
  # @return true if the user rated this teacher
  def has_rated_teacher?(teacher)
    rating = Rating.find_by_user_id_and_teacher_id(self.id, teacher.id)
    (!rating.nil?)
  end

  private

  # Takes the password present in the class and encrypts it, assigning it to the class variable encrypted password
  def encrypt_password
    self.salt = make_salt unless has_password?(password)
    self.encrypted_password = encrypt(password)
  end

  # Encrypts the received string
  #
  # @param [String] string The string to be encrypted
  # @return [String] string The encrypted string
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  # Creates a Salt for the user (see http://en.wikipedia.org/wiki/Salt_(cryptography))
  #
  # @return [String] Generated salt
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  # Generates a hash from a string following
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
