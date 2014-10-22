class CreateIngredientsRecipes < ActiveRecord::Migration
  def self.up
    create_table :ingredients_recipes, :id => false do |t|
        t.references :ingredient
        t.references :recipe
    end
    add_index :ingredients_recipes, [:ingredient_id, :recipe_id]
    add_index :ingredients_recipes, :recipe_id
  end

  def self.down
    drop_table :ingredients_recipes
  end
end
