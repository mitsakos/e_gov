# encoding: utf-8
class SessionsController < ApplicationController

	def new
	end

	# Handling authentication when user submits login form
	# with authenticate method. If the authentication is
	# successful stores a permanent or temporary cookie based
	# on selection :remember_me with an authorization token
	# and redirects to root_url with notice else displays
	# alert and redirects to new
	def create
		user = User.authenticate(params[:email], params[:password])
		if user
			if params[:remember_me]
				cookies.permanent[:auth_token] = user.auth_token
			else
				cookies[:auth_token] = user.auth_token
			end
			redirect_to root_url, :notice => "Συνδεθήκατε!"
		else
			flash.alert = "Λάθος e-mail ή κωδικός"
			redirect_to root_url
		end
	end

	# Deleting cookie and redirecting to root_url on
	# logout with notice
	def destroy
		cookies.delete(:auth_token)
		redirect_to root_url, :notice => "Αποσυνδεθήκατε!"
	end

end