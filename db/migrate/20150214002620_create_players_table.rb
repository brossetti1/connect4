class CreatePlayersTable < ActiveRecord::Migration
  def change
    create_table :players_tables do |t|
      t.integer :user_id
      t.integer :game_id
    end
  end
end
