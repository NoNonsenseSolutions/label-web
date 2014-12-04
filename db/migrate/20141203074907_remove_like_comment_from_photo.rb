class RemoveLikeCommentFromPhoto < ActiveRecord::Migration
  def up
  	remove_column :photos, :like
  	remove_column :photos, :comment
  end

  def down
  	add_column :photos, :like, :integer
  	add_column :photos, :comment, :string
  end
end
