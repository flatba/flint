class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job, :string
    add_column :users, :introduction, :text
  end
end
