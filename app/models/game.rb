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

  #def update_board(spot)
  #  if current_user.id == @game.current_player
  #  end
  #end

  #def random_player_pick
  #  rand(2) == 1 ? @user.user_id : current_user.id
  #end


  def winner?(column)
    col_height = calculate_column_height(column)
    if verticalWin?(column.to_i, col_height.to_i) || horizontalWin?(column.to_i, col_height.to_i) ||
        diagonalDownWin?(column.to_i, col_height.to_i) || diagonalUpWin?(column.to_i, col_height.to_i)
        puts "#{self.state[x][y]} won!!"
        return true
    else
      return false
    end
    #|| diagonalUpWin?
  end

  def diagonalUpWin?(x,y)
    if x<=4 && y>=3
      if(self.state[x][y]==self.state[x+1][y-1])&&(self.state[x+1][y-1]==self.state[x+2][y-2])&&(self.state[x+2][y-2]==self.state[x+3][y-3])
        return true
      end
    end
    if x>=4 && y<=3
      if(self.state[x][y]==self.state[x-1][y+1])&&(self.state[x-1][y+1]==self.state[x-2][y+2])&&(self.state[x-2][y+2]==self.state[x-3][y+3])
        return true
      end
    end
    if x<=4 && y>=3
      if(self.state[x][y]==self.state[x+1][y-1])&&(self.state[x+1][y-1]==self.state[x+2][y-2])&&(self.state[x+2][y-2]==self.state[x+3][y-3])
        return true
      end
    end
    if x>=2 && x<=5 && y>=2 && y<=4
      if(self.state[x-1][y+1]==self.state[x][y])&&(self.state[x][y]==self.state[x+1][y-1])&&(self.state[x+1][y-1]==self.state[x+2][y-2])
        return true
      end
    end
    if x>=3 && x<=6 && y>=1 && y<=3
      if(self.state[x-2][y+2]==self.state[x-1][y+1])&&(self.state[x-1][y+1]==self.state[x][y])&&(self.state[x][y]==self.state[x+1][y-1])
        return true
      end
    end
    return false
  end

  def diagonalDownWin?(x,y)
    if x <= 4 && y <=2
      if (self.state[x][y] == self.state[x+1][y+1])&&(self.state[x+1][y+1] == self.state[x+2][y+2])&&(self.state[x+2][y+2] == self.state[x+3][y+3])
        return true
      end
    end
    if x>=2 && x <=5 && y<=3
      if (self.state[x-1][y-1] == self.state[x][y])&&(self.state[x][y] == self.state[x+1][y+1])&&(self.state[x+1][y+1] == self.state[x+2][y+2])
        return true
      end
    end
    if x>=3 && x<=6 && y>=2 && y<=4
      if (self.state[x-2][y-2] == self.state[x-1][y-1])&&(self.state[x-1][y-1] == self.state[x][y])&&(self.state[x][y] == self.state[x+1][y+1])
        return true
      end
    end
    if (x>=4 && y==5) || (x==7&&y>=3)
      if (self.state[x-3][y-3] == self.state[x-2][y-2])&&(self.state[x-2][y-2] == self.state[x-1][y-1])&&(self.state[x-1][y-1] == self.state[x][y])
        return true
      end
    end
    return false
  end

  def horizontalWin?(x,y)
    col = x
    case col
    when 1 then horizontalRight?(x,y)
    when 2 then horizontalRight?(x,y) || horizontalOnePlaceLeft?(x,y)
    when 3 then horizontalRight?(x,y) || horizontalOnePlaceLeft?(x,y) || horizontalTwoPlacesLeft?(x,y)
    when 4 then horizontalRight?(x,y) || horizontalOnePlaceLeft?(x,y) || horizontalTwoPlacesLeft?(x,y) || horizontalLeft?(x,y)
    when 5 then horizontalOnePlaceLeft?(x,y) || horizontalTwoPlacesLeft?(x,y) || horizontalLeft?(x,y)
    when 6 then horizontalTwoPlacesLeft?(x,y) || horizontalLeft?(x,y)
    when 7 then horizontalLeft?(x,y)
    end

  end

  def horizontalRight?(x,y)
    if (self.state[x][y]==self.state[x+1][y]) && (self.state[x+1][y]==self.state[x+2][y]) && (self.state[x+2][y]==self.state[x+3][y])
      return true
    else
      return false
    end
  end

  def horizontalLeft?(x,y)
    if (self.state[x][y]==self.state[x-1][y]) && (self.state[x-1][y]==self.state[x-2][y]) && (self.state[x-2][y]==self.state[x-3][y])
      return true
    else
      return false
    end
  end

  def horizontalTwoPlacesLeft?(x,y)
    if (self.state[x-2][y]==self.state[x-1][y]) && (self.state[x-1][y]==self.state[x][y]) && (self.state[x][y]==self.state[x+1][y])
      return true
    else
      return false
    end
  end

  def horizontalOnePlaceLeft?(x,y)
    if (self.state[x-1][y]==self.state[x][y]) && (self.state[x][y]==self.state[x+1][y]) && (self.state[x+1][y]==self.state[x+2][y])
      return true
    else
      return false
    end
  end
# x is columns and y is rows
# x is input and y is calculated
# x is @col and y is column

  def verticalWin?(x,y)
    if y <= 2
      if (self.state[x][y]==self.state[x][y+1]) && (self.state[x][y+1]==self.state[x][y+2]) && (self.state[x][y+2]==self.state[x][y+3])
        return true
      end
    else
      return false
    end
  end

  def diagonalUpWin?
    #TODO:
  end



  def show_board
    puts "\n
         #{self.state[1][0]} | #{self.state[2][0]} | #{self.state[3][0]} | #{self.state[4][0]} | #{self.state[5][0]} | #{self.state[6][0]} | #{self.state[7][0]}
          ---------------------------------------------
         #{self.state[1][1]} | #{self.state[2][1]} | #{self.state[3][1]} | #{self.state[4][1]} | #{self.state[5][1]} | #{self.state[6][1]} | #{self.state[7][1]}
          ---------------------------------------------
         #{self.state[1][2]} | #{self.state[2][2]} | #{self.state[3][2]} | #{self.state[4][2]} | #{self.state[5][2]} | #{self.state[6][2]} | #{self.state[7][2]}
          ---------------------------------------------
         #{self.state[1][3]} | #{self.state[2][3]} | #{self.state[3][3]} | #{self.state[4][3]} | #{self.state[5][3]} | #{self.state[6][3]} | #{self.state[7][3]}
          ---------------------------------------------
         #{self.state[1][4]} | #{self.state[2][4]} | #{self.state[3][4]} | #{self.state[4][4]} | #{self.state[5][4]} | #{self.state[6][4]} | #{self.state[7][4]}
          ---------------------------------------------
         #{self.state[1][5]} | #{self.state[2][5]} | #{self.state[3][5]} | #{self.state[4][5]} | #{self.state[5][5]} | #{self.state[6][5]} | #{self.state[7][5]}
          ---------------------------------------------

      \n"
  end

  def place_token_on_board(col, token)
    col_height = calculate_column_height(col)
    self.state[col][col_height]=token
  end

  def calculate_column_height(col)
    col_height = 5
    while self.state[col][col_height].length!=2 && col_height >=0
      col_height -= 1
    end
    if col_height == -1
      puts "Column is full."
      pick_spot
    end
    col_height.to_i
  end

  def pick_spot(column)
    col = column.to_i
    token = self.current_player_id == self.current_user.user_id ? 'red' : 'black'
    place_token_on_board(col, token)
  end

  def take_turn
    #puts "It is #{@next_player.username}'s turn."
    #show_board
    pick_spot
    self.current_player_id = self.current_user.user_id == self.current_player_id ? player2.user_id : current_user.user_id
    self.turn_count -= 1
  end

  def draw?
    self.turn_count.zero? && !winner?
  end

  def finished?(column)
    draw? || winner?(column)
  end

  def player2
    self.users[1]
  end

  #refactor to controller without a loop.
  #def connect_four(column)
  #  until finished?(column)
  #    take_turn(column)
  #  end
  #  show_board
  #end
end
