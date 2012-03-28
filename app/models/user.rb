class User < ActiveRecord::Base

  require 'valid_email'

  attr_accessor :password
  attr_accessible :last_name, :first_name, :description, :email, :cellphone, :password, :password_confirmation

  validates :last_name, :presence => true
  validates :first_name, :presence => true
  validates :email, :presence => true, :email => true
  validates :password, :confirmation => true, :presence => true, :length => {:minimum => 5}

  before_save :encrypt_password

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