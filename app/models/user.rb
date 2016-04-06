class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :comment, presence: true, length: { maximum: 140 }, on: :update
  validates :age, presence: true, numericality: { only_integer: true },inclusion: { in:1..100}, on: :update
  
  has_secure_password
  validates :password, length: { in: 4..20 }, allow_nil:true
  
  
  has_many :microposts
  
  
  #部分的に自由
  has_many :bookmarks_relationships, class_name:  "Bookmark",
                                   foreign_key: "user_id",
                                   dependent:   :destroy #いないuserデータを消す
  has_many :bookmark_microposts, through: :bookmarks_relationships, source: :micropost


  # 他のユーザーをお気に入り
  def bookmark(other_micropost)
    bookmarks_relationships.find_or_create_by(micropost_id: other_micropost.id)
  end
  # お気に入りしているユーザーをお気に入り外す
  def unbookmark(other_micropost)
    bookmark_relationship = bookmarks_relationships.find_by(micropost_id: other_micropost.id)
    bookmark_relationship.destroy if bookmark_relationship
  end
  # あるユーザーをお気に入りしているかどうか？
  def bookmark?(other_micropost)
    bookmark_microposts.include?(other_micropost)
  end
  

  #フォローする (active)
  has_many :following_relationships, class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  #フォローされる (passive)
  has_many :follower_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
    
    
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
