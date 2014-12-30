class ChangeLikesCountDefaultPhoto < ActiveRecord::Migration
  def change
  	change_column_default :photos, :likes_count, 0
  end
end
