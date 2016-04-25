class Message < ActiveRecord::Base
	# validates :title, :presence => true, :length => { :maximum => 10 }
	validates :body, :presence => true, :length => { :maximum => 100 }

	# メッセージを新しい順に並べ替える
	# def self.message_list
	# 	return Message.all.order(:created_at => :desc)
	# end
	
	belongs_to :user_like
end
