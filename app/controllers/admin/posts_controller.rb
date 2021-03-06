# encoding: utf-8
class Admin::PostsController < ApplicationController

	before_filter :authorize_admin

	# GET /posts
	# GET /posts.json
	# Show all posts can be formatted in html and json
	def index
		@posts = Post.all
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @posts }
		end
	end

	# GET /posts/1
	# GET /posts/1.json
	# Show single post by id can be formatted in html and json
	def show
		@post = Post.find(params[:id])
		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @post }
		end
	end

	# GET /posts/new
	# GET /posts/new.json
	# Instantiate an empty post object 
	def new
		@post = Post.new
		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @post }
		end
	end

	# GET /posts/1/edit
	# Eequest to edit_post_path(@post) by id
	def edit
		@post = Post.find(params[:id])
	end

	# POST /posts
	# POST /posts.json
	# Instantiate a post object from data supplied redirects
	# to newly created post if successful else to new action
	def create
		@post = Post.new(params[:post])
		@post.user_id = current_user.id
		respond_to do |format|
			if @post.save
				format.html { redirect_to admin_post_path(@post), notice: 'Η ανάρτηση δημιουργήθηκε με επιτυχία' }
				format.json { render json: @post, status: :created, location: [:admin,@post] }
			else
				format.html { render action: "new" }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /posts/1
	# PUT /posts/1.json
	# Updating post found by id redirects to updated
	# post if successful else to edit action
	def update
		@post = Post.find(params[:id])
		respond_to do |format|
			if @post.update_attributes(params[:post])
				format.html { redirect_to admin_posts_url, notice: 'Η ανάρτηση άλλαξε με επιτυχία.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /posts/1
	# DELETE /posts/1.json
	# Remove the corresponding post from the database
	# and redirect to posts#index
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		respond_to do |format|
			format.html { redirect_to admin_posts_path }
			format.json { head :no_content }
		end
	end

	def delete
		@post = Post.find(params[:id])
		@rel_comments = Comment.where("post_id" => @post.id)
		respond_to do |format|
			format.html
			format.json { render json: @post }
		end
	end

end