class AddPhotoIdToTags < ActiveRecord::Migration
  def change
  	add_column :tags, :photo_id, :integer, references: :photos
  end
end
