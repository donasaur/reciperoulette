class CreateBlockrecipelistsRecipes < ActiveRecord::Migration
  def self.up
    create_table :blockedrecipelists_recipes, :id => false do |t|
        t.belongs_to :blockedrecipelist
        t.belongs_to :recipe
    end
  end

  def self.down
    drop_table :blockedrecipelists_recipes
  end
end
