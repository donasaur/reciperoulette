class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :recipes

  def to_s
  	name
  end
end
