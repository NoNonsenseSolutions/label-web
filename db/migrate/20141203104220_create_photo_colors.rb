class CreatePhotoColors < ActiveRecord::Migration
  def change
    create_table :photo_colors do |t|
      t.references :photo, index: true
      t.references :color, index: true

      t.timestamps null: false
    end
  end
end
