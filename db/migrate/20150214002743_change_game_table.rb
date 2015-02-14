class ChangeGameTable < ActiveRecord::Migration
  def change
    remove_column :games, :player1_id
    remove_column :games, :player2_id
    add_column :games, :finished, :boolean, :default => false, :null => false
    add_column :games, :players_count, :integer
  end
end
