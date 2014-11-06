class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes, uniq: true
  validates :name, presence: true, uniqueness: true
end
