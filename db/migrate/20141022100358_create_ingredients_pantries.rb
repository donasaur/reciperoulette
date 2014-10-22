class CreateIngredientsPantries < ActiveRecord::Migration

  def self.up
    create_table :ingredients_pantries, :id => false do |t|
        t.references :ingredient
        t.references :pantry
    end
    add_index :ingredients_pantries, [:ingredient_id, :pantry_id]
    add_index :ingredients_pantries, :pantry_id
  end

  def self.down
    drop_table :ingredients_pantries
  end
  
end
