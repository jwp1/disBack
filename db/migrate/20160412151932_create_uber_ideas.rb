class CreateUberIdeas < ActiveRecord::Migration
  def change
    create_table :uber_ideas do |t|
      t.references :game, index: true
      t.references :player, index: true
      t.integer :strength
      t.integer :votes
      t.string :description

      t.timestamps null: false
    end
    add_foreign_key :uber_ideas, :games
    add_foreign_key :uber_ideas, :players
  end
end
