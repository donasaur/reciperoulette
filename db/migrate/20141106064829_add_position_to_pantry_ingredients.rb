class AddPositionToPantryIngredients < ActiveRecord::Migration
  def change
    add_column :pantry_ingredients, :position, :integer, default: 0
  end
end
