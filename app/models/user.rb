class User < ActiveRecord::Base
  has_many :follower_relationships, class_name: "Relationship", foreign_key: "following_id"
  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id"
  has_many :followers, through: :follower_relationships
  has_many :followeds, through: :followed_relationships

  def following? user
    self.followings.include? user
  end
 
  def follow user
      Relationship.create follower_id: self.id, following_id: user.id
  end
end
