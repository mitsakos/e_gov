# encoding: utf-8
class PollsController < ApplicationController

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

	def vote
		@poll = Poll.find(params[:id])
		if  current_user && params[:poll_option] && params[:poll_option][:id] && !(PollResponse.find_by_poll_id_and_user_id(@poll.id, current_user.id))
			@poll_option = @poll.poll_options.find_by_id(params[:poll_option][:id])
			@poll.votes_count += 1
			@poll_option.poll_responses_count += 1
			@poll_response = @poll.poll_responses.build
			@poll_response.user_id = current_user.id
			@poll_response.poll_id = @poll.id
			@poll_response.poll_option_id = @poll_option.id
			respond_to do |format|
				if @poll.update_attributes(params[:poll]) && @poll_option.update_attributes(params[:poll_option]) && @poll_response.update_attributes(params[:poll_response])
					format.html { redirect_to @poll, notice: 'Ευχαριστούμε που ψηφίσατε' }
					format.json { head :no_content }
				else
					format.html { render action: "show" }
	 			end
			end
		else
			flash[:error] = 'you have not voted!'
			redirect_to @poll
		end
	end

	def create_table(object)
		options_array = object.poll_options.all.map { |x| x.option }  
		poll_count_array = object.poll_options.all.map { |x| x.poll_responses_count }  
		merged_array = options_array.zip(poll_count_array).flatten.compact  
		merged_array.each_slice(2).to_a.inspect
	end

end
