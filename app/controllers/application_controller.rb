# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # An around filter that catches exceptions in the API and returns the content of the exception serialized
  around_filter do |controller, action_block|

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

end
