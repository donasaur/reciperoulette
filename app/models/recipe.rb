class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :tags, uniq: true
  has_and_belongs_to_many :ingredients, :uniq => true
  has_and_belongs_to_many :blockedrecipelists, :uniq => true, :read_only => true
  has_and_belongs_to_many :users, :uniq => true

  has_attached_file :image, styles: {
    thumb: '100x100>',
    medium: '500x500>',
    large:  '1000x1000>'
  }

  validates :name, presence: true, uniqueness: true

  validates_attachment :image, 
  :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  :size => { :in => 0..2.megabytes }



  def to_s
    name
  end
end
