class Admin::PollsController < ApplicationController

	before_filter :authorize_admin
	helper_method :create_table

	# GET /polls
	# GET /polls.json
	def index
		@polls = Poll.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @polls }
		end
	end

	# GET /polls/1
	# GET /polls/1.json
	def show
		@poll = Poll.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @poll }
		end
	end

	# GET /polls/new
	# GET /polls/new.json
	def new
		@poll = Poll.new
		3.times { @poll.poll_options.build }

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @poll }
		end
	end

	# GET /polls/1/edit
	def edit
		@poll = Poll.find(params[:id])
	end

	# POST /polls
	# POST /polls.json
	def create
		@poll = Poll.new(params[:poll])

		respond_to do |format|
			if @poll.save
				format.html { redirect_to admin_poll_path(@poll), notice: 'Poll was successfully created.' }
				format.json { render json: @poll, status: :created, location: @poll }
			else
				3.times { @poll.poll_options.build }
				format.html { render action: "new" }
				format.json { render json: @poll.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /polls/1
	# PUT /polls/1.json
	def update
		@poll = Poll.find(params[:id])

		respond_to do |format|
			if @poll.update_attributes(params[:poll])
				format.html { redirect_to admin_poll_path(@poll), notice: 'Poll was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @poll.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /polls/1
	# DELETE /polls/1.json
	def destroy
		@poll = Poll.find(params[:id])
		@poll.destroy

		respond_to do |format|
			format.html { redirect_to admin_polls_path }
			format.json { head :no_content }
		end
	end

	def vote
		@poll = Poll.find(params[:id])
		if  params[:poll_option] and params[:poll_option][:id]
			@poll_option = @poll.poll_options.find_by_id(params[:poll_option][:id])
			@poll.votes_count += 1
			@poll_option.poll_responses_count += 1
			@poll_response = @poll.poll_responses.build
			@poll_response.user_id = current_user.id
			@poll_response.poll_id = @poll.id
			@poll_response.poll_option_id = @poll_option.id
			respond_to do |format|
				if @poll.update_attributes(params[:poll]) && @poll_option.update_attributes(params[:poll_option]) && @poll_response.update_attributes(params[:poll_response])
					format.html { redirect_to admin_poll_path(@poll), notice: 'Thank you for voting' }
					format.json { head :no_content }
				else
					format.html { render action: "show" }
	 			end
			end
		else
			flash[:error] = 'you have not voted!'
			redirect_to admin_poll_path(@poll)
		end
	end

	def create_table(object)
		options_array = object.poll_options.all.map { |x| x.option }  
		poll_count_array = object.poll_options.all.map { |x| x.poll_responses_count }  
		merged_array = options_array.zip(poll_count_array).flatten.compact  
		merged_array.each_slice(2).to_a.inspect
	end

	def delete
		@poll = Poll.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @poll }
		end
	end

end
