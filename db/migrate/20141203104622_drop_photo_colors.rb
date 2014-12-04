class DropPhotoColors < ActiveRecord::Migration
  def up
  	drop_table :photo_colors
  end

  def down
    create_table :photo_colors do |t|
      t.references :photo, index: true
      t.references :color, index: true

      t.timestamps null: false
    end
  end
end
