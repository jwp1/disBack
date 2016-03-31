class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.string :picture
      t.string :categories
      t.boolean :temporary
      t.integer :popularity, :default => 0

      t.timestamps null: false
    end
  end
end
