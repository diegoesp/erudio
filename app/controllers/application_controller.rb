# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protect_from_forgery
  respond_to :json

  # An around filter that catches exceptions in the API and returns the content of the exception serialized
  around_filter do |controller, action_block|

    # put "true" in this condition if you don't want to have the API filtered with an errors JSON returned (userful for testing purposes)
    if (false)
      action_block.call
      return
    end
    
    # If the called method is an API then the returned value cannot be a 500 page, but a 402 JSON error
    if controller.action_name.starts_with?("api_")
      begin
        action_block.call
      rescue Exception => e
        exception = { :class => e.class.name, :message => e.message }
        respond_with(exception.to_json, :status => 406)
      end
    else
      action_block.call
    end

  end

  before_filter :require_login

  private

  # Raises an exception if the user is not logged in the app
  # @raise [Error] An error if the user is not logged in
  def require_login

    raise "a user must be logged to execute this action" unless signed_in?

  end

end
