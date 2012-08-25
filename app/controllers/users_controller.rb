class UsersController < ApplicationController

  # Creating a new user instance
  def new
    @user = User.new
  end

  # Creating a new user instance based on user's parameters
  # if validation succeeds sending registraion confirmation
  # mail and redirecting to root_url with appropriate notice
  # else renders new action
  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
end
