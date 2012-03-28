# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  protect_from_forgery

  respond_to :json

  # Logs the user into the application
  #
  # @param [String] email User email used as username
  # @param [String] password User password
  # @return [String] JSON containing the user logged in, or a null JSON if the user failed to login, a string "null"
  def api_login

    email = params[:email]
    password = params[:password]

    raise "must specify email parameter" unless !email.nil?
    raise "must specify password parameter" unless !password.nil?

    user = User.authenticate(email, password)

    sign_in(user) unless user.nil?
    respond_with(user)
  end

  # Logs out the present user from the app.
  # @return [String] a null JSON string => "null"
  def api_logout
    sign_out
    respond_with(nil)
  end
end