class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :tag_id
      t.integer :like
      t.string :comment
      t.string :qrcode
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
