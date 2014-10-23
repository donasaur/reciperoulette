class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :recipes
  has_one :blockedrecipelist
  has_one :pantry
  before_create :build_pantry
  before_create :build_blockedrecipelist
end
