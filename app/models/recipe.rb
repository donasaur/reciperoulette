class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients, :uniq => true
  has_and_belongs_to_many :blockedrecipelists, :uniq => true, :read_only => true
  has_and_belongs_to_many :users, :uniq => true

  def to_s
    name
  end
end
