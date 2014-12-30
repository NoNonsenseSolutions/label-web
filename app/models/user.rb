class User < ActiveRecord::Base
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "following_id"
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, through: :follower_relationships
  has_many :followeds, through: :followed_relationships
  has_many :photos
  mount_uploader :photo, PhotoUploader


  def following? user
    self.followings.include? user
  end
 
  def follow user
      Relationship.create follower_id: self.id, following_id: user.id
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.username = auth[:info][:name]
      user.email = auth[:info][:email]
      user.oauth_token = auth[:credentials][:token]
      user.oauth_expires_at = Time.at(auth[:credentials][:expires_at])
      user.gender = auth[:extra][:gender]
      user.photo = auth[:info][:image]
      user.save!
    end
  end


end
