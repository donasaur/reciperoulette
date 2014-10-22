class Pantry < ActiveRecord::Base
  # has_many :ingredients_pantries
  # has_many :ingredients, through: :ingredients_pantries
  has_and_belongs_to_many :ingredients
  belongs_to :user

  def add_ingredient()
  end
end
