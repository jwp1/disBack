class AddPlayerCountToGame < ActiveRecord::Migration
  def change
    add_column :games, :player_count, :integer
  end
end
