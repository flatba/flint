class Message < ActiveRecord::Base
	# validates :title, :presence => true, :length => { :maximum => 10 }
	validates :body, :presence => true, :length => { :maximum => 100 }
	
	belongs_to :user_like
end
