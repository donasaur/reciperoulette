class DropIngredientsPantriesTable < ActiveRecord::Migration
  def up
    drop_table :ingredients_pantries
  end

  def down
    create_table :ingredients_pantries do |t|
      t.belongs_to :pantry
      t.belongs_to :ingredient
    end
  end
end
