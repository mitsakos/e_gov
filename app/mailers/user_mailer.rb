class UserMailer < ActionMailer::Base
  def registration_confirmation(user)
  	@user = user
    mail(:to => user.email, :subject => "Registration confirmation", :from => "webmaster@e_gov.com")
  end

  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Password Reset", :from => "webmaster@e_gov.com")
  end
end
