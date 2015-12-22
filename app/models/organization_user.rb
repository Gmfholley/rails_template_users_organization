class OrganizationUser < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  belongs_to :role
  
  validates :user, presence: true
  validates :role, presence: true
  validates :organization, presence: true
  validates_uniqueness_of :user_id, scope: :organization_id
  
end
