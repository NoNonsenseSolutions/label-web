class DropTablePhotoTags < ActiveRecord::Migration
  def up
  	drop_table :photo_tags
  end

  def down
    create_table :photo_tags do |t|
      t.references :photo, index: true
      t.references :tags, index: true
    end
  end
end
