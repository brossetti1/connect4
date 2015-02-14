class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  #belongs_to :player1_id, :class_name => 'User'
  #belongs_to :player2_id, :class_name => 'User'
  
  validates_length_of :users, maximum: 2, message: "you can only have two players."
  serialize :state

  def self.waiting
    Game.where(:players_count => 1)
  end

  def self.active
    Game.where(:finished => false)
  end
end
