# encoding: utf-8
class Admin::RepliesController < ApplicationController

	before_filter :authorize_admin

	def index
		@replies = Reply.order("topic_id")
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @replies }
		end
	end

	def show
		@reply = Reply.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @reply }
		end
	end

	def new
		@reply = Reply.new
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @reply }
		end
	end

	# GET /replies/1/edit
	def edit
		@reply = Reply.find(params[:id])
	end

	# POST /replies
	# POST /replies.json
	def create
		@reply = Reply.new(params[:reply])
		@reply.user_id = current_user.id
		@reply.topic_id = params[:reply][:topic_id]

		respond_to do |format|
			if @reply.save
				format.html { redirect_to admin_reply_path(@reply), notice: 'Η απάντηση δημιουργήθηκε με επιτυχία' }
				format.json { render json: @reply, status: :created, location: @reply }
			else
				format.html { redirect_to admin_reply_path(@reply), alert: 'Η απάντηση ήταν άκυρη' }
				format.json { render json: @reply.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /replies/1
	# PUT /replies/1.json
	def update
		@reply = Reply.find(params[:id])
		@reply.topic_id = params[:reply][:topic_id]

		respond_to do |format|
			if @reply.update_attributes(params[:reply])
				format.html { redirect_to admin_reply_path(@reply), notice: 'Η απάντηση άλλαξε με επιτυχία' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @reply.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /replies/1
	# DELETE /replies/1.json
	def destroy
		@reply = Reply.find(params[:id])
		@reply.destroy

		respond_to do |format|
			format.html { redirect_to admin_replies_path }
			format.json { head :no_content }
		end
	end

	def delete
		@reply = Reply.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @reply }
		end
	end
	
end
