class Pantry < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  belongs_to :user
  validates :user_id, presence: true
end
