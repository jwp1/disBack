class AddSubmittingOverToGame < ActiveRecord::Migration
  def change
    add_column :games, :submitting_over, :boolean
  end
end
