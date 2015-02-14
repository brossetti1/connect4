class ChangeStateColumnOnGame < ActiveRecord::Migration
  def change
    change_column :games, :state, :string
  end
end
