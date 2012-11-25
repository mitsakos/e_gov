class Forum < ActiveRecord::Base

	# Limiting mass assignment for security
	attr_accessible :description, :title
	# Creating assosiations with topics
	has_many :topics, :dependent => :destroy

	# Form input validations
	validates :title, :presence => true, :length => { :minimum => 5 }
	validates :description, :presence => true, :length => { :minimum => 10 }

	# Returns the most recent topic
	def most_recent_post  
		topic = Topic.first(:order => 'last_post_at DESC', :conditions => ['forum_id = ?', self.id])  
		return topic  
	end

end
