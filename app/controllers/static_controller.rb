class StaticController < ApplicationController

	def contact
	end

	def links
	end

	def send_contact
		subject = params[:subject]
		name = params[:name]
		email = params[:email]
		body = params[:body]
		
		if UserMailer.contact(subject, name, email, body).deliver
			flash[:notice] = "Sent!"
		else
			flash[:notice] = "Could't send you message."
		end
		redirect_to contact_url
	end

end
