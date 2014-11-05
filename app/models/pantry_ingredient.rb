class PantryIngredient < ActiveRecord::Base
  belongs_to :pantry
  belongs_to :ingredient
end
