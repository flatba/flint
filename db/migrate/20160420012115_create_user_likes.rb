class CreateUserLikes < ActiveRecord::Migration
  def change
    create_table :user_likes do |t|
      t.integer :user_id
      t.integer :like_id
      t.integer :matching

      t.timestamps null: false
    end
  end
end
