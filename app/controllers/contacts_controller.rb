# encoding: utf-8
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
				flash[:notice] = "Το μύνημά σας εστάλη!"
				redirect_to contacts_url
			else
				render "index" 
			end
		else
			@contact.errors[:base] << "Η αναγνώριση ήταν λάθος!"
			render "index"
		end
	end

end
