# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token      :string
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test 'organizations should not save without names' do
    a = Organization.new
    assert_not a.save
  end
  
  test 'organizations should have many users' do
    assert_instance_of User, organizations(:bank).users.first
  end
  
  
end
