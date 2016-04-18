class CreateActiveIdeas < ActiveRecord::Migration
  def change
    create_table :active_ideas do |t|
      t.belongs_to :game, index: true
      t.belongs_to :idea, index: true
      t.integer :round
      t.integer :votes
      t.timestamps null: false
    end
  end
end
