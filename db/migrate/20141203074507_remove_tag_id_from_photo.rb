class RemoveTagIdFromPhoto < ActiveRecord::Migration
  def up
  	remove_column :photos, :tag_id
  end

  def down
  	add_column :photos, :tag_id, :integer
  end
end
