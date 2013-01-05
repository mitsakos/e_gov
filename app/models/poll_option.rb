class PollOption < ActiveRecord::Base

	# Creating assosiations
	belongs_to :poll
	has_many :poll_responses, :dependent => :destroy
	# Limiting mass assignment for security
	attr_accessible :option, :poll_responses_count

end
