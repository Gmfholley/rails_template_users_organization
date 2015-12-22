# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  validates :name, presence: true
  has_many :users
  
  
  # finds Role id with a name of admin
  #
  # returns an integer
  def self.admin_id
    Role.find_by(name: 'admin').id
  end

  # finds Role id with a name of user
  #
  # returns an integer  
  def self.user_id
    Role.find_by(name: 'user').id
  end
  
end
