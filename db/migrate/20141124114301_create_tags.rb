class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :field
      t.string :value

      t.timestamps null: false
    end
  end
end
