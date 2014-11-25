class Relationship < ActiveRecord::Base
  belongs_to :follower, classname: "User"
  belongs_to :following, classname: "User"
end
