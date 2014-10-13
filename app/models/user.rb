class User < ActiveRecord::Base
  has_many :recipes
  has_one :pantry

end
