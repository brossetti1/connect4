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

  def winner?(column)
    column = column.to_i
    col_height = calculate_column_height(column) + 1
    if verticalWin?(column, col_height) ||
        horizontalWin?(column, col_height) ||
        diagonalDownWin?(column, col_height) ||
        diagonalUpWin?(column, col_height)
        return true
    else
      return false
    end
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

  def place_token_on_board(column, token)
    col_height = calculate_column_height(column)
    self.state[column][col_height] = token
    self.save
  end

  def calculate_column_height(column)
    col_height = 5
    while self.state[column][col_height].length!=2 && col_height >=0
      col_height -= 1
    end
    if col_height == -1
      return false
    end
    col_height.to_i
  end

  def pick_spot(column, user)
    column = column.to_i
    token = self.current_player_id == self.players[0].user_id ? 'red' : 'black'
    place_token_on_board(column, token)
    self.switch_players(user)
    return process_finished_game if finished?(column)
    self.turn_count -= 1
  end

  def switch_players(user)
    self.current_player_id = user.id == self.current_player_id ? player2.id : user.id
  end

  def draw?(column)
    self.turn_count.zero? && !winner?(column)
  end

  def finished?(column)
    draw?(column) || winner?(column)
  end

  def player2
    self.users[1]
  end

  def winning_player_id
    self.current_player_id == player2.id ? self.users[0].id : player2.id
  end

  def player_picking_currently
    user_id = self.current_player_id
    user = User.find(user_id)
  end

  def winner
    user_id = self.winner_id
    User.find(user_id)
  end

  def process_finished_game
    self.winner_id = self.winning_player_id
    self.finished = true
    winner
  end

  def send_notice
    "#{player_picking_currently.username}'s turn"
  end

  def send_alert
    "you cant go there #{player_picking_currently.username}, pick again!"
  end

end
