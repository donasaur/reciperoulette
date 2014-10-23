class CreateBlockedrecipelists < ActiveRecord::Migration
  def change
    create_table :blockedrecipelists do |t|

      t.timestamps
    end
  end
end
