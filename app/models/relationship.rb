class Relationship < ActiveRecord::Base
  # 12.2 UserとRelationshipの関連付け(user.rb & relationship.rb)
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
