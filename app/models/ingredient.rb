class Ingredient < ActiveRecord::Base
  # has_and_belongs_to_many :recipes
  # has_many :ingredients_pantries
  # has_many :pantries, through: :ingredients_pantries
  has_and_belongs_to_many :pantries
  has_and_belongs_to_many :recipes
end
