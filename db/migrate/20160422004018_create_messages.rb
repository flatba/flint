class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      # t.references :name, index: true, foreign_key: true
      t.references :user_like, index: true, foreign_key: true
      # t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
