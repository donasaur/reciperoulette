class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps
    end

    create_table :recipes_tags do |t|
      t.belongs_to :tag
      t.belongs_to :recipe
    end
  end
end
