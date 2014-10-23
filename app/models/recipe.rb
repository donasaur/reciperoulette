class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :blockedrecipelists, :uniq => true, :read_only => true
  has_and_belongs_to_many :users

  def to_s
    name
  end
end
