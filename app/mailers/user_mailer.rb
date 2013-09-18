# encoding: utf-8
class UserMailer < ActionMailer::Base

	# Assigning values to registration confirmation mail
	def registration_confirmation(user)
		@user = user
		mail(:to => user.email, :subject => "Επιβεβαίωση εγγραφής", :from => "webmaster@e_gov.com")
	end

	# Assigning values to password reset mail
	def password_reset(user)
		@user = user
		mail(:to => user.email, :subject => "Επαναφορά κωδικού", :from => "webmaster@e_gov.com")
	end

	def contact(subject, name, email, body)
		@subject = subject
		@name = name
		@email = email
		@body = body
		mail(:to => "jim_metal@yahoo.com", :subject => @subject, :from => "webmaster@e_gov.com")
	end
	
end
