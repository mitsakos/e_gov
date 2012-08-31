class Post < ActiveRecord::Base

	# Creating assosiations with users and comments
	belongs_to :user
	has_many :comments, :dependent => :destroy
	# Limiting mass assignment for security
	attr_accessible :content, :title, :photo

	# Form input validations
	validates :title, :presence => true,
					:length => { :minimum => 5 }

	# Papaerclip addition
	has_attached_file :photo, :styles => { :small => "150x150>", :large => "300x300>" }

	# Paperclip validations
	validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

end
