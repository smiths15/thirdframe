class AddPictureToFrame < ActiveRecord::Migration[5.0]
  def change
    add_column :frames, :picture, :string
  end
end
