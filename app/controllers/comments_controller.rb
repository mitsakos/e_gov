class CommentsController < ApplicationController

	# Finding the post in question creating the comment
	# associated with the post and redirecting to post
	# responding in html or javascript 
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(params[:comment])
		@comment.user_id = current_user.id
		@comment.save
		respond_to do |format|
			format.html { redirect_to post_path(@post) }
			format.js
		end
	end

	# Finding the post in question deleting the comment
	# associated with the post and redirecting to post
	# responding in html or javascript
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		# redirect_to post_path(@post)
		respond_to do |format|
			format.html { redirect_to post_path(@post) }
			format.js
		end
	end

end
