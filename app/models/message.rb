class Message < ActiveRecord::Base
    # validates :title, :presence => true, :length => { :maximum => 10 }
    validates :body, :presence => true, :length => { :maximum => 100 }
    belongs_to :user_like
    belongs_to :user
    belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
    belongs_to :sender, class_name: "User", foreign_key: "sender_id"
end
