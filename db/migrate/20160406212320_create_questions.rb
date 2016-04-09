class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :round
      t.references :game, index: true

      t.timestamps null: false
    end
    add_foreign_key :questions, :games
  end
end
