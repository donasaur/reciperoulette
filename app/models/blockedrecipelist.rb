class Blockedrecipelist < ActiveRecord::Base
  has_and_belongs_to_many :recipes, :uniq => true, :read_only => true
  belongs_to :user

  validates :user_id, presence: true
end
