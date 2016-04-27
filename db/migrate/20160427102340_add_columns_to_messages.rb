class AddColumnsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sender, :integer
    add_column :messages, :receiver, :integer
  end
end
