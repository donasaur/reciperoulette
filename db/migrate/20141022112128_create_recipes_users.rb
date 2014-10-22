class CreateRecipesUsers < ActiveRecord::Migration
  def self.up
    create_table :recipes_users, :id => false do |t|
        t.references :recipe
        t.references :user
    end
    add_index :recipes_users, [:recipe_id, :user_id]
    add_index :recipes_users, :user_id
  end

  def self.down
    drop_table :recipes_users
  end
end
