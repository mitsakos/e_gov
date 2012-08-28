class CommentsController < ApplicationController

	# Finding the post in question creating the comment
	# associated with the post and redirecting to post
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(params[:comment])
		@comment.user_id = current_user.id
		@comment.save
		redirect_to post_path(@post)
	end

	# Finding the post in question deleting the comment
	# associated with the post and redirecting to post
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

end
