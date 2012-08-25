class PasswordResetsController < ApplicationController

	def new
	end

	# Fetching user by email if user present calls
	# send_password_reset method to send reset mail
	# and redirects to root_url with notice
	def create
		user = User.find_by_email(params[:email])
		user.send_password_reset if user
		redirect_to root_url, :notice => "Email sent with password reset instructions."
	end

	# Fetching user based on the reset token
	def edit
		@user = User.find_by_password_reset_token!(params[:id])
	end

	# Fetching user and checking if reset token has expired
	# if not updating the user password else display alert
	def update
		@user = User.find_by_password_reset_token!(params[:id])
		if @user.password_reset_sent_at < 2.hours.ago
			redirect_to new_password_reset_path, :alert => "Password reset has expired."
		elsif @user.update_attributes(params[:user])
			redirect_to root_url, :notice => "Password has been reset!"
		else
			render :edit
		end
	end
	
end
