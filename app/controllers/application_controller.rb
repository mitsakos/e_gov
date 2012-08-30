class ApplicationController < ActionController::Base

	protect_from_forgery
	# Making the method current_user available in the view
	helper_method :current_user
	# helper_method :admin?

	protected

	# Authorizing user
	def authorize
		unless admin?
			flash[:error] = "Unauthorized access"
			redirect_to root_url
			false
		end		
	end

	# Determining if current user is administrator 
	def admin?
		if current_user != nil && current_user.administrator
			true
		else
			false
		end			
	end

	private

	# Checking if the current user is logged in
	def current_user
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end
	
end
