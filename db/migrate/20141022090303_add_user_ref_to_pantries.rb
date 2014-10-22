class AddUserRefToPantries < ActiveRecord::Migration
  def change
    add_reference :pantries, :user, index: true
  end
end
