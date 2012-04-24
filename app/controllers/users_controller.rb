# -*- encoding : utf-8 -*-
# Manages the Users resources
class UsersController < ApplicationController

  respond_to :json
  skip_before_filter :require_login, :only => [:login]

  # Logs the user into the application
  #
  # @param [String] email User email used as username
  # @param [String] password User password
  # @return [String] JSON containing the user logged in, or a null JSON if the user failed to login, a string "null"
  def login

    email = params[:email]
    password = params[:password]

    raise "must specify email parameter" if email.nil?
    raise "must specify password parameter" if password.nil?

    user = User.authenticate(email, password)

    sign_in(user) unless user.nil?
    respond_with(user)
  end

  # Logs out the present user from the app.
  # @return [String] a null JSON string => "null"
  def logout
    sign_out
    respond_with(nil)
  end
end