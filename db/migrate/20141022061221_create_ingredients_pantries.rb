class CreateIngredientsPantries < ActiveRecord::Migration
  def change
    create_table :ingredients_pantries do |t|
      t.belongs_to :ingredient
      t.belongs_to :pantry
      t.timestamps
    end

    create_table :ingredients_recipes do |t|
      t.belongs_to :ingredient
      t.belongs_to :recipe
      t.timestamps
    end
  end
end
