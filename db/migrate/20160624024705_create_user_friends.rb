class CreateUserFriends < ActiveRecord::Migration
  def change
    create_table :user_friends do |t|
      t.integer :uid
      t.string :name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
