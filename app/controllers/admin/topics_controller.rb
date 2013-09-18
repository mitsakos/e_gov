# encoding: utf-8
class Admin::TopicsController < ApplicationController

	before_filter :authorize_admin

	# GET /topics
	# GET /topics.json
	# Show all topics can be formatted in html and json
	def index
		@topics = Topic.order("forum_id")
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @topics }
		end
	end

	# GET /topics/1
	# GET /topics/1.json
	def show
		@topic = Topic.find(params[:id])
		@replies = @topic.replies.order("created_at DESC")

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @topic }
		end
	end

	# GET /topics/new
	# GET /topics/new.json
	def new
		@topic = Topic.new
		@reply = @topic.replies.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @topic }
		end
	end

	# GET /topics/1/edit
	def edit
		@topic = Topic.find(params[:id])
	end

	# POST /topics
	# POST /topics.json
	def create
		@topic = Topic.new(params[:topic])
		@reply = @topic.replies.new(params[:reply])
		@reply.user_id = current_user.id
		@topic.user_id = current_user.id
		@topic.forum_id = params[:topic][:forum_id]
		@topic.last_poster_id = current_user.id
		@topic.last_post_at = Time.now
		@topic.save

		respond_to do |format|
			if @topic.save && @reply.save
				format.html { redirect_to admin_topic_path(@topic), notice: 'Το θέμα δημιουργήθηκε με επιτυχία' }
				format.json { render json: @topic, status: :created, location: @topic }
			else
				format.html { render action: "new" }
				format.json { render json: @topic.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /topics/1
	# PUT /topics/1.json
	def update
		@topic = Topic.find(params[:id])
		@topic.forum_id = params[:topic][:forum_id]

		respond_to do |format|
			if @topic.update_attributes(params[:topic])
				format.html { redirect_to admin_topic_path(@topic), notice: 'Το θέμα άλλαξε με επιτυχία' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @topic.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /topics/1
	# DELETE /topics/1.json
	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		respond_to do |format|
			format.html { redirect_to admin_topics_path }
			format.json { head :no_content }
		end
	end

	def delete
		@topic = Topic.find(params[:id])
		@rel_replies = Reply.where("topic_id" => @topic.id)
		respond_to do |format|
			format.html
			format.json { render json: @topic }
		end
	end

end
