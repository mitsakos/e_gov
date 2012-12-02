class TopicsController < ApplicationController

	before_filter :authorize_user, :except => [:index, :show]

	# GET /topics/1
	# GET /topics/1.json
	def show
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @topic }
		end
	end

	# GET /topics/new
	# GET /topics/new.json
	def new
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.new
		@reply = @topic.replies.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @topic }
		end
	end

	# GET /topics/1/edit
	def edit
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:id])
	end

	# POST /topics
	# POST /topics.json
	def create
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.new(params[:topic])
		@reply = @topic.replies.new(params[:reply])
		@reply.user_id = current_user.id
		@topic.user_id = current_user.id
		@topic.forum_id = @forum.id
		@topic.last_poster_id = current_user.id
		@topic.last_post_at = Time.now
		@topic.save

		respond_to do |format|
			if @topic.save && @reply.save
				format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Topic was successfully created.' }
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
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:id])

		respond_to do |format|
			if @topic.update_attributes(params[:topic])
				format.html { redirect_to forum_url(@forum), notice: 'Topic was successfully updated.' }
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
		@forum = Forum.find(params[:forum_id])
		@topic = @forum.topics.find(params[:id])
		@topic.destroy

		respond_to do |format|
			format.html { redirect_to forum_url(@forum) }
			format.json { head :no_content }
		end
	end

end
