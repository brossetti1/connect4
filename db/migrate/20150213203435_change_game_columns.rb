class ChangeGameColumns < ActiveRecord::Migration
  def change
    change_column :games, :current_player, :integer
    rename_column :games, :current_player, :current_player_id
    change_column :games, :player1_id, :integer
    change_column :games, :player2_id, :integer
  end
end
