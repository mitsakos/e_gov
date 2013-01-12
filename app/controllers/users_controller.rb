class UsersController < ApplicationController 

	# Creating a new user instance
	def new
		@user = User.new
	end

	def show
		@user = User.find_by_id(current_user.id)
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @user }
		end
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

	def edit
		@user = User.find_by_id(current_user.id)
	end

	def update
		@user = User.find_by_id(current_user.id)
		respond_to do |format|
			if @user.update_attributes(params[:user])
				format.html { redirect_to profile_path, notice: 'Profile was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end
	
end