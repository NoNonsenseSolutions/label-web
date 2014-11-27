class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :qrcodes
  has_many :tags
  mount_uploader :file, PhotoUploader
end
