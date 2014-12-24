class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :user, :email, :string
  end
end
