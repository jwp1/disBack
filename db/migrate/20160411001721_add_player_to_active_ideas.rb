class AddPlayerToActiveIdeas < ActiveRecord::Migration
  def change
    add_reference :active_ideas, :player, index: true
    add_foreign_key :active_ideas, :players
  end
end
