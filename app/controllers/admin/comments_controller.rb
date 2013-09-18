# encoding: utf-8
class Admin::CommentsController < ApplicationController

	before_filter :authorize_admin

	# GET /comments
	# GET /comments.json
	# Show all comments can be formatted in html and json
	def index
		@comments = Comment.order("post_id")
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @comments }
		end
	end

	# GET /comments/1
	# GET /comments/1.json
	# Show single comment by id can be formatted in html and json
	def show
		@comment = Comment.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @comment }
		end
	end

	# GET /comments/new
	# GET /comments/new.json
	# Instantiate an empty comment object 
	def new
		@comment = Comment.new
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @comment }
		end
	end

	# GET /comments/1/edit
	# Request to edit_admin_comment_path(@comment) by id
	def edit
		@comment = Comment.find(params[:id])
	end

	# Finding the post in question creating the comment
	# associated with the post and redirecting to post
	# responding in html or javascript 
	def create
		#@post = Post.find(params[:post_id])
		@comment = Comment.new(params[:comment])
		@comment.post_id = params[:comment][:post_id]
		@comment.user_id = current_user.id
		if @comment.save
			respond_to do |format|
				format.html { redirect_to admin_comment_path(@comment) }
			end
		else
			respond_to do |format|
				format.html { redirect_to admin_comments_path, alert: 'Μή έγκυρο σχόλιο' }
			end
		end
	end

	# PUT /comments/1
	# PUT /comments/1.json
	# Updating comment found by id redirects to updated
	# comment if successful else to edit action
	def update
		@comment = Comment.find(params[:id])
		@comment.post_id = params[:comment][:post_id]
		respond_to do |format|
			if @comment.update_attributes(params[:comment])
				format.html { redirect_to admin_comments_url, notice: 'Το σχόλιο άλλαξε με επιτυχία' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	# Finding the post in question deleting the comment
	# associated with the post and redirecting to post
	# responding in html or javascript
	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to admin_comments_path }
		end
	end

	def delete
		@comment = Comment.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @comment }
		end
	end

end
