class Admin::CommentsController < ApplicationController

	before_filter :authorize_user

	# Finding the post in question creating the comment
	# associated with the post and redirecting to post
	# responding in html or javascript 
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.new(params[:comment])
		@comment.user_id = current_user.id
		if @comment.save
			respond_to do |format|
				format.html { redirect_to admin_post_path(@post) }
				format.js
			end
		else
			respond_to do |format|
				format.html { redirect_to admin_post_path(@post), alert: 'Invalid Comment' }
				format.js { render :js => "alert('Invalid Comment');" }
			end
		end
	end

	# Finding the post in question deleting the comment
	# associated with the post and redirecting to post
	# responding in html or javascript
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to admin_post_path(@post) }
			format.js
		end
	end

end
