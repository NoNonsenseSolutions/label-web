class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.references :photo, index: true

      t.timestamps null: false
    end
  end
end
