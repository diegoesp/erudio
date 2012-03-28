# -*- encoding : utf-8 -*-
# Defines needed functionality for managing sessions
# Contains a module variable called current_user which holds the user logged in
module SessionsHelper

  # Signs in a given user, saving its id and salt into the session
  # @param [String] user The user to be signed in
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end

  # Saves the user in a local variable for later use
  #
  # @param [User] a logged user
  def current_user=(user)
    @current_user = user
  end

  # Returns the user currently logged in the session
  #
  # @return [User] The user currently logged in the session
  def current_user
    @current_user ||= user_from_remember_token
  end

  # Determines if there's someone logged in now. Use current_user instance variable to get the user if this method returns true
  # @return [Boolean] true if there's a user signed in now
  def signed_in?
    !current_user.nil?
  end

  # Signs out the present user, erasing the session
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end