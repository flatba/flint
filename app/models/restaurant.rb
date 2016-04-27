class Restaurant < ActiveRecord::Base
	belongs_to :user

	# validates :comment, presence: true, length: { maximum: 50 } # 50文字まで
end
