class AddRestaurantToUserLikes < ActiveRecord::Migration
  def change
    add_reference :user_likes, :restaurant, index: true, foreign_key: true
  end
end
