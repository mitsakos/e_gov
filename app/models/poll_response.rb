class PollResponse < ActiveRecord::Base

	# Creating assosiations
	belongs_to :poll
	belongs_to :user
	belongs_to :poll_option

end
