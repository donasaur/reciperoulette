class CreateAddUserRefToBlockedrecipelists < ActiveRecord::Migration
  def change
    add_reference :blockedrecipelists, :user, index: true
  end
end
