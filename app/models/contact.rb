class Contact

	include ActiveAttr::Model

	attribute :subject
	attribute :name
	attribute :email
	attribute :body

	validates :subject, :presence => true
	validates :name, :presence => true
	validates :email, :presence => true
	validates :body, :presence => true
	validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
	
end