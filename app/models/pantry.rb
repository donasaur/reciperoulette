class Pantry < ActiveRecord::Base
  has_many :pantry_ingredients
  has_many :ingredients, through: :pantry_ingredients
  belongs_to :user
  validates :user_id, presence: true
end
