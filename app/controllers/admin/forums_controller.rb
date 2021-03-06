# encoding: utf-8
class Admin::ForumsController < ApplicationController

	before_filter :authorize_admin
  
	# GET /forums
	# GET /forums.json
	def index
		@forums = Forum.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @forums }
		end
	end

	# GET /forums/1
	# GET /forums/1.json
	def show
		@forum = Forum.find(params[:id])
		@topics = @forum.topics.order("created_at DESC")

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @forum }
		end
	end

	# GET /forums/new
	# GET /forums/new.json
	def new
		@forum = Forum.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @forum }
		end
	end

	# GET /forums/1/edit
	def edit
		@forum = Forum.find(params[:id])
	end

	# POST /forums
	# POST /forums.json
	def create
		@forum = Forum.new(params[:forum])

		respond_to do |format|
			if @forum.save
				format.html { redirect_to admin_forums_path, notice: 'Το forum δημιουργήθηκε με επιτυχία' }
				format.json { render json: @forum, status: :created, location: @forum }
			else
				format.html { render action: "new" }
				format.json { render json: @forum.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /forums/1
	# PUT /forums/1.json
	def update
		@forum = Forum.find(params[:id])

		respond_to do |format|
			if @forum.update_attributes(params[:forum])
				format.html { redirect_to @forum, notice: 'Το forum άλλαξε με επιτυχία' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @forum.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /forums/1
	# DELETE /forums/1.json
	def destroy
		@forum = Forum.find(params[:id])
		@forum.destroy

		respond_to do |format|
			format.html { redirect_to admin_forums_url }
			format.json { head :no_content }
		end
	end

	def delete
		@forum = Forum.find(params[:id])
		@rel_topics = Topic.where("forum_id" => @forum.id)
		respond_to do |format|
			format.html
			format.json { render json: @post }
		end
	end
	
end
