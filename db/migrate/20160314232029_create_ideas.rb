class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.integer :popularity, :default => 0

      t.timestamps null: false
    end
  end
end
