class AddVotesToActiveIdeas < ActiveRecord::Migration
  def change
    add_column :active_ideas, :votes, :integer
  end
end
