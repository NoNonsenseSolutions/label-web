class CreateQrcodes < ActiveRecord::Migration
  def change
    create_table :qrcodes do |t|
      t.integer :photo_id

      t.timestamps null: false
    end
  end
end
