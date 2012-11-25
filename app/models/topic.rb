class Topic < ActiveRecord::Base
  belongs_to :forum
  belongs_to :user
  has_many :replies, :dependent => :destroy
  attr_accessible :last_post_at, :last_poster_id, :title
end
