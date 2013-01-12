# == Schema Information
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  username               :string(255)
#  email                  :string(255)
#  password_hash          :string(255)
#  password_salt          :string(255)
#  administrator          :boolean(1)
#  moderator              :boolean(1)
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime

class User < ActiveRecord::Base

	# Creating assosiations
	has_many :posts
	has_many :comments
	has_many :poll_responses
	has_many :topics
	has_many :replies
	# Limiting mass assignment for security
	attr_accessible :username, :email, :password, :password_confirmation, :avatar
	# Making needed attributes available
	attr_accessor :password

	# Papaerclip addition
	has_attached_file :avatar, :styles => { :small => "40x40>", :large => "200x200>" },
								:default_url => '/assets/default-avatar-:style.png'

	# Paperclip validations
	validates_attachment_size :avatar, :less_than => 5.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']

	# Method calls before creating and saving users
	before_create { generate_token(:auth_token) }
	before_save :encrypt_password

	# Form input validations
	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_presence_of :username
	validates_uniqueness_of :username

	# Authenticating users by creating a password hash
	# from the given password and comparing it with the
	# stored value
	# input : email, password
	# output : user if password is correct nil if not
	def self.authenticate(email, password)
		user = find_by_email(email)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end

	# Creating the password salt and hash
	# using methods from bcrypt gem
	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end

	# Generating a token for users session management
	# and ensuring that it is unique
	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	# Generating password reset token, saving
	# a timestamp so it can expire and sending
	# password reset mail
	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end
	
end
