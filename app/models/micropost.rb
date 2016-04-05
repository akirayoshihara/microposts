class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  
  validates :user_id, presence:true
  validates :content, presence:true, length: { maximum: 140 }
end
