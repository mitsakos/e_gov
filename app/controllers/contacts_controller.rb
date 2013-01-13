class ContactsController < ApplicationController

	def index
		@contact = Contact.new
	end

	def send_contact
		@contact = Contact.new(params[:contact])
		subject = params[:contact][:subject]
		name = params[:contact][:name]
		email = params[:contact][:email]
		body = params[:contact][:body]
		
		if verify_recaptcha() 
			if @contact.valid? && UserMailer.contact(subject, name, email, body).deliver
				flash[:notice] = "Your message has been sent!"
				redirect_to contacts_url
			else
				render "index" 
			end
		else
			@contact.errors[:base] << "Captcha is wrong!"
			render "index"
		end
	end

end
