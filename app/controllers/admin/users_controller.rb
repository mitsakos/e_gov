# encoding: utf-8
class Admin::UsersController < ApplicationController

	before_filter :authorize_admin

	def index
		@users = User.all
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @users }
		end
	end

	def show
		@user = User.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @user }
		end
	end

	# Creating a new user instance
	def new
		@user = User.new
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @post }
		end
	end

	# Creating a new user instance based on user's parameters
	# if validation succeeds sending registraion confirmation
	# mail and redirecting to root_url with appropriate notice
	# else renders new action
	def create
		@user = User.new(params[:user])
		if @user.save
			redirect_to admin_users_path, :notice => "Ο χρήστης δημιουργήθηκε με επιτυχία!"
		else
			render "new"
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		respond_to do |format|
			if @user.update_attributes(params[:user])
				format.html { redirect_to profile_path, notice: 'Ο χρήστης άλλαξε με επιτυχία' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		respond_to do |format|
			format.html { redirect_to admin_users_path }
			format.json { head :no_content }
		end
	end

	def delete
		@user = User.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @user }
		end
	end
	
end