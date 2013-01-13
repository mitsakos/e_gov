class Contact

	include ActiveAttr::Model

	attribute :subject
	attribute :name
	attribute :email
	attribute :body

	validates_presence_of :subject
	validates_presence_of :name
	validates_presence_of :email
	validates_presence_of :body
	validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
	
end