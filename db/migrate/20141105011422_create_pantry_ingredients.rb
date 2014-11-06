class CreatePantryIngredients < ActiveRecord::Migration
  def change
    create_table :pantry_ingredients do |t|
      t.belongs_to :pantry
      t.belongs_to :ingredient
      t.boolean    :active
      t.timestamps
    end
  end
end
