class CreatePhotoTags < ActiveRecord::Migration
  def change
    create_table :photo_tags do |t|
      t.references :photo, index: true
      t.references :tags, index: true
    end
  end
end
