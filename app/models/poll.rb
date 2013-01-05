class Poll < ActiveRecord::Base

	# Creating assosiations
	has_many :poll_options, :dependent => :destroy
	has_many :poll_responses, :dependent => :destroy
	# Polls accept nested form attributes for poll_options and poll_responses
	accepts_nested_attributes_for :poll_options, :poll_responses, :reject_if => proc { |a| a['option'].blank? }, :allow_destroy => true
	# Limiting mass assignment for security
	attr_accessible :question, :poll_options_attributes, :poll_responses_attributes

	# Form input validations
	validates :question, :presence => true

end
