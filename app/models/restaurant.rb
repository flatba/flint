class Restaurant < ActiveRecord::Base
	has_many :users

	validates :comment, presence: true, length: { maximum: 50 } # 50文字まで
end
