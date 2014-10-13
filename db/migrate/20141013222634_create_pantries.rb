class CreatePantries < ActiveRecord::Migration
  def change
    create_table :pantries do |t|

      t.timestamps
    end
  end
end
