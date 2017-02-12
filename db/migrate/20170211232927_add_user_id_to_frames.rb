class AddUserIdToFrames < ActiveRecord::Migration[5.0]
  def change
    add_column :frames, :user_id, :integer
    add_index :frames, :user_id
  end
end
