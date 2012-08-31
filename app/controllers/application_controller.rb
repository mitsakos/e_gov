class ApplicationController < ActionController::Base

	protect_from_forgery
	# Making the method current_user available in the view
	helper_method :current_user, :is_owner
	helper_method :admin?

	protected

	# Determining if current user is owner of object
	def is_owner(object)
		if current_user && ( current_user.id == object.user_id )
			true
		else
			false
		end		
	end


	# Authorizing users
	def authorize_user
		if current_user
			true
		else
			flash[:error] = "You need to log in!"
			redirect_to root_url
			false
		end		
	end

	# Authorizing administrator
	def authorize_admin
		unless admin?
			flash[:error] = "Unauthorized access"
			redirect_to root_url
			false
		end		
	end

	# Determining if current user is administrator 
	def admin?
		current_user && current_user.administrator				
	end

	private

	# Checking if the current user is logged in
	def current_user
		@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end
	
end
