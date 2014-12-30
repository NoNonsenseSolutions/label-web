class RenamePhotoForUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :photo
  	add_column :users, :profile_pic, :string
  end

  def down
  	remove_column :users, :profile_pic
  	add_column :users, :photo, :string
  end
end
