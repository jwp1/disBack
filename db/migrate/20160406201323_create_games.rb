class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :rounds
      t.integer :input_timer
      t.integer :battle_timer

      t.timestamps null: false
    end
  end
end
