class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :user_id
      t.integer :frame_id
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :frame_id
  end
end
