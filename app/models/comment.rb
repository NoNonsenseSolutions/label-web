class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  validates :body, presence: true

  def user_info
  	{ name: self.user.name, profile_pic: self.user.profile_pic.url }
  end


end
