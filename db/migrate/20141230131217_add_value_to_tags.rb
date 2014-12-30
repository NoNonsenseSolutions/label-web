class AddValueToTags < ActiveRecord::Migration
  def change
    add_column :tags, :value, :string
    add_index :tags, :value
	  add_index :tags, :field
	  add_index :tags, :photo_id
  end

end
