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

class Organization < ActiveRecord::Base
  validates :name, presence: true
  
  has_many :users
  accepts_nested_attributes_for :users, reject_if: :all_blank
  
  before_create :generate_token


  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Challenge.exists?(token: random_token)
    end
  end
end
