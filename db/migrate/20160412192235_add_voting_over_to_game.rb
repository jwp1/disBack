class AddVotingOverToGame < ActiveRecord::Migration
  def change
    add_column :games, :voting_over, :boolean
  end
end
