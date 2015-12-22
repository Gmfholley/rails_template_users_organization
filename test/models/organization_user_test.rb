# == Schema Information
#
# Table name: organization_users
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  user_id         :integer
#  role_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class OrganizationUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
