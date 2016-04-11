class AddWinnerToActiveIdeas < ActiveRecord::Migration
  def change
    add_column :active_ideas, :winner, :boolean
  end
end
