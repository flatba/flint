class AddRestrauntToUserLikes < ActiveRecord::Migration
  def change
    add_reference :user_likes, :restraunt, index: true, foreign_key: true
  end
end
