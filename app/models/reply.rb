class Reply < ActiveRecord::Base

	# Creating assosiations with topics and users
	belongs_to :topic
	belongs_to :user
	# Limiting mass assignment for security
	attr_accessible :body, :topic_id

	# Form input validations
	validates :body, :presence => true

end
