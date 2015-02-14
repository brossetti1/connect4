class AddTurnCountToGame < ActiveRecord::Migration
  def change
    add_column :games, :turn_count, :integer, :default => 42
  end
end
