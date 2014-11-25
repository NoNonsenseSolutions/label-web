class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :gender
      t.string :body_size
      t.integer :following
      t.string :photo
      t.string :needlist
      t.string :closet

      t.timestamps null: false
    end
  end
end
