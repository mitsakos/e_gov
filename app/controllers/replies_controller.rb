class RepliesController < ApplicationController

  before_filter :authorize_user, :except => [:index, :show]
  
  # GET /replies
  # GET /replies.json
  def index
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @replies = @topic.replies.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replies }
    end
  end

  # GET /replies/1
  # GET /replies/1.json
  def show
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @reply = @topic.replies.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reply }
    end
  end

  # GET /replies/new
  # GET /replies/new.json
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @reply = @topic.replies.new(params[:reply])

    respond_to do |format|
      format.html { redirect_to forum_topic_path(@forum, @topic) } # new.html.erb
      format.json { render json: @reply }
    end
  end

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
        format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Reply was successfully created.' }
        format.json { render json: @reply, status: :created, location: @reply }
      else
        format.html { render action: "new" }
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
        format.html { redirect_to forum_topic_path(@forum, @topic), notice: 'Reply was successfully updated.' }
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
