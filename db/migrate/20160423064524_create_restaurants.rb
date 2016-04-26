class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :category
      t.integer :price
      t.float :star
      t.string :area
      t.string :image
      t.string :comment
      t.references :user, index: true, foreign_key: true
      t.integer :payment

      t.timestamps null: false
    end

  end
end
