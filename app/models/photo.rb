class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :likes, :qrcodes, :tags
end
