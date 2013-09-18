class PostsController < ApplicationController


	# GET /posts
	# GET /posts.json
	# Show all posts can be formatted in html and json
	def index
		@posts = Post.order("created_at").page(params[:page]).per(8)
		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @posts }
			format.rss
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

end