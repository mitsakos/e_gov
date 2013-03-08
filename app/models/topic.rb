class Topic < ActiveRecord::Base

	# Creating assosiations with forums, users and replies
	belongs_to :forum
	belongs_to :user
	has_many :replies, :dependent => :destroy
	# Limiting mass assignment for security
	attr_accessible :title, :forum_id

	# Form input validations
	validates :title, :presence => true, :length => { :minimum => 5 }

end
