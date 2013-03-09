class Event < ActiveRecord::Base

	# Limiting mass assignment for security
	attr_accessible :content, :ev_date, :name, :photo

	# Papaerclip addition
	has_attached_file :photo, :styles => { :small => "150x150>", :large => "300x300>" }

	# Paperclip validations
	validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

end
