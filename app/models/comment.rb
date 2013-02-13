class Comment < ActiveRecord::Base

	# Creating assosiation with users and posts
	belongs_to :user
	belongs_to :post
	# Limiting mass assignment for security
	attr_accessible :body, :post_id

	# Form input validations
	validates :body, :presence => true

end
