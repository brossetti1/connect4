class ChangeStateGameHash < ActiveRecord::Migration
  def change
    change_column :games, :state, :string, :default => { 1 => [0,1,2,3,4,5], 2 => [0,1,2,3,4,5], 3 => [0,1,2,3,4,5], 4 => [0,1,2,3,4,5], 5 => [0,1,2,3,4,5], 6 => [0,1,2,3,4,5], 7 => [0,1,2,3,4,5] }
  end
end
