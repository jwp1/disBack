class AddWinnerToUberIdea < ActiveRecord::Migration
  def change
    add_column :uber_ideas, :winner, :boolean
  end
end
