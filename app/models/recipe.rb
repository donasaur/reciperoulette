class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients, :uniq => true
  has_and_belongs_to_many :blockedrecipelists, :uniq => true, :read_only => true
  has_and_belongs_to_many :users, :uniq => true

  has_attached_file :image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large:  '1000x1000>'
  }

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
