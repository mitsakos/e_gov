class UserMailer < ActionMailer::Base

	# Assigning values to registration confirmation mail
	def registration_confirmation(user)
		@user = user
		mail(:to => user.email, :subject => "Registration confirmation", :from => "webmaster@e_gov.com")
	end

	# Assigning values to password reset mail
	def password_reset(user)
		@user = user
		mail(:to => user.email, :subject => "Password Reset", :from => "webmaster@e_gov.com")
	end
	
end
