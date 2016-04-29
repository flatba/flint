class Restaurant < ActiveRecord::Base
	belongs_to :user
  has_many :user_likes

  validates :comment, presence: true, length: { maximum: 50 } # 50文字まで

end
