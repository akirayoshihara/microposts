class Micropost < ActiveRecord::Base
  belongs_to :user

  has_many :bookmarks_ralationships, class_name:  "Bookmark",
                                   foreign_key: "micropost_id",
                                   dependent:   :destroy #いないuserデータを消す
  has_many :bookmark_users, through: :bookmarks_relationships, source: :user


  validates :user_id, presence:true
  validates :content, presence:true, length: { maximum: 140 }
end
