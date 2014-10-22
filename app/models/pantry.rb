class Pantry < ActiveRecord::Base
  has_many :ingredients, through: :ingredients_pantries
  belongs_to :user

  def add_ingredient()
  end
end
