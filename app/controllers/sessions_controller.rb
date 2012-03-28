# -*- encoding : utf-8 -*-
class SessionsController < ApplicationControll

	def api_login
		user = User.authenticate(params[:email], params[:password])

	end
end