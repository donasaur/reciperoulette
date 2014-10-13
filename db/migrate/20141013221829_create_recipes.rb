class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string  :name
      t.string  :tag
      t.text    :instructions
      t.integer :prep_time
      t.integer :cook_time

      t.timestamps
    end
  end
end
