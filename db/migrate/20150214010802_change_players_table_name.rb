class ChangePlayersTableName < ActiveRecord::Migration
  def change
    rename_table :players_tables, :players
  end
end
