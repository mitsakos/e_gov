class Post < ActiveRecord::Base

	# Creating assosiations with users and comments
	belongs_to :user
	has_many :comments, :dependent => :destroy
	# Limiting mass assignment for security
	attr_accessible :content, :title

	# Form input validations
	validates :title, :presence => true,
					:length => { :minimum => 5 }

end
