class User < ApplicationRecord
  mount_uploader :profile, ProfileUploader

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
