class RemoveValueFromTags < ActiveRecord::Migration
  def up
  	remove_column :tags, :value
  end

  def down
  	add_column :tags, :value, :string
  end
end
