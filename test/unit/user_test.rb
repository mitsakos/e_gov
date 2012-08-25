require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
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
#

