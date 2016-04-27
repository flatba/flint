class UserLike < ActiveRecord::Base
	## user_likeテーブル
	# B:user_like -> A:user
	belongs_to :like, class_name: "User", foreign_key: "like_id"
	# B:user_like -> C:user
  belongs_to :liker, class_name: "User", foreign_key: "user_id"

  has_many :messages
end
