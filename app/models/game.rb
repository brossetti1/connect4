class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  
  validates_length_of :users, maximum: 2, message: "you can only have two players."
  serialize :state

  def self.waiting
    Game.where(:players_count => 1)
  end

  def self.active
    Game.where(:finished => false)
  end

  # $board = {1=>["a1","a2","a3","a4","a5","a6"],
           # 2=>["b1","b2","b3","b4","b5","b6"],
           # 3=>["c1","c2","c3","c4","c5","c6"],
           # 4=>["d1","d2","d3","d4","d5","d6"],
           # 5=>["e1","e2","e3","e4","e5","e6"],
           # 6=>["f1","f2","f3","f4","f5","f6"],
           # 7=>["g1","g2","g3","g4","g5","g6"]}

  def update_board(spot)
    if current_user.id == @game.current_player
    end
  end

  #def random_player_pick
  #  rand(2) == 1 ? @user.user_id : current_user.id
  #end

end


