class ChangeColumnsInPhotoTags < ActiveRecord::Migration
  def up
  	remove_column :photo_tags, :tags_id
  	add_column :photo_tags, :tag_id, :integer
  end

  def remove
  	remove_column :photo_tags, :tag_id
  	add_column :photo_tags, :tags_id, :integer
  end
end
