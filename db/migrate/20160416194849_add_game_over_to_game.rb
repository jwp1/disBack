class AddGameOverToGame < ActiveRecord::Migration
  def change
    add_column :games, :game_over, :boolean
  end
end
