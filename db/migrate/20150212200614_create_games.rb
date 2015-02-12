class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :player1
      t.string :player2
      t.text :state
      t.string :current_player

      t.timestamps null: false
    end
  end
end
