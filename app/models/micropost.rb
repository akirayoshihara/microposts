class Micropost < ActiveRecord::Base
  belongs_to :user
<<<<<<< HEAD
  validates :user_id, presence:true
  validates :content, presence:true, length: { maximum: 140 }
end
=======
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
>>>>>>> master
