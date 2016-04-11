class AddCurrentRoundToGame < ActiveRecord::Migration
  def change
    add_column :games, :current_round, :integer
  end
end
