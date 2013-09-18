# encoding: utf-8
class RepliesController < ApplicationController

	before_filter :authorize_user, :except => [:index, :show]

	# GET /replies/1/edit
	def edit
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:topic_id])
		@reply = @topic.replies.find(params[:id])
	end

	# POST /replies
	# POST /replies.json
	def create
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:topic_id])
		@reply = @topic.replies.new(params[:reply])
		@reply.user_id = current_user.id

		respond_to do |format|
			if @reply.save
				format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Η απάντηση δημιουργήθηκε με επιτυχία' }
				format.json { render json: @reply, status: :created, location: @reply }
			else
				format.html { redirect_to forum_topic_path(@forum, @topic), alert: 'Η απάντηση ήταν άκυρη' }
				format.json { render json: @reply.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /replies/1
	# PUT /replies/1.json
	def update
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:topic_id])
		@reply = @topic.replies.find(params[:id])

		respond_to do |format|
			if @reply.update_attributes(params[:reply])
				format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Η απάντηση άλλαξε με επιτυχία' }
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
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:topic_id])
		@reply = @topic.replies.find(params[:id])
		@reply.destroy

		respond_to do |format|
			format.html { redirect_to forum_topic_path(@forum, @topic) }
			format.json { head :no_content }
		end
	end
	
end
