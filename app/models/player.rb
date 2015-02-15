class Player < ActiveRecord::Base
  belongs_to :game, :counter_cache => true
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :game_id
end



###### activate associations #######
#
# player1 = User.find(4)
# player2 = User.find(5)
# game = Game.new
# game.users = [player1, player2]
# game.save
#
####################################
