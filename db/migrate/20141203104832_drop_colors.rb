class DropColors < ActiveRecord::Migration
  def up
  	drop_table :colors
  end

  def down
    create_table :colors do |t|
      t.references :photo, index: true
      t.string :code
    end
  end
end
