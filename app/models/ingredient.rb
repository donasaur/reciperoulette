class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :recipes
  has_many :pantry_ingredients
  has_many :pantries, through: :pantry_ingredients
  validates :name, presence: true, uniqueness: true
  
  def to_s
  	name
  end
end
