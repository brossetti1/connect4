class ChangeGamePlayers < ActiveRecord::Migration
  def change
    rename_column :games, :player1, :player1_id
    rename_column :games, :player2, :player2_id
    add_column :users, :wins, :integer
    add_column :users, :losses, :integer
    add_column :users, :ties, :integer
  end
end
