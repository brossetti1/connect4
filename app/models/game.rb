class Game < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players
  #belongs_to :player1_id, :class_name => 'User'
  #belongs_to :player2_id, :class_name => 'User'

  validates_length_of :users, maximum: 2, message: "you can only have two players."
  serialize :state

  $board = {1=>["a1","a2","a3","a4","a5","a6"],
            2=>["b1","b2","b3","b4","b5","b6"],
            3=>["c1","c2","c3","c4","c5","c6"],
            4=>["d1","d2","d3","d4","d5","d6"],
            5=>["e1","e2","e3","e4","e5","e6"],
            6=>["f1","f2","f3","f4","f5","f6"],
            7=>["g1","g2","g3","g4","g5","g6"]}


  def initialize( player1, player2)
    @board = $board
    @player1 = player1
    @player2 = player2
    @player1token = 'red'
    @player2token = 'black'
    @turns = 42
    @row = 1
    @col = 0
    @next_player = @player1 #maybe randomize?
    super()
  end

  def self.waiting
    Game.where(:players_count => 1)
  end

  def self.active
    Game.where(:finished => false)
  end

  def winner?
    if verticalWin?(@row.to_i,@col.to_i) || horizontalWin?(@row.to_i,@col.to_i) ||
        diagonalDownWin?(@row.to_i,@col.to_i)
        puts "#{@board[x][y]} won!!"
        return true
    else
      return false
    end
    #|| diagonalUpWin?
  end

  def diagonalDownWin?(x,y)
    if x <= 4 && y <=2
      if (@board[x][y] == @board[x+1][y+1])&&(@board[x+1][y+1] == @board[x+2][y+2])&&(@board[x+2][y+2] == @board[x+3][y+3])
        return true
      end
    end
    if x>=2 && x <=5 && y<=3
      if (@board[x-1][y-1] == @board[x][y])&&(@board[x][y] == @board[x+1][y+1])&&(@board[x+1][y+1] == @board[x+2][y+2])
        return true
      end
    end
    if x>=3 && x<=6 && y>=2 && y<=4
      if (@board[x-2][y-2] == @board[x-1][y-1])&&(@board[x-1][y-1] == @board[x][y])&&(@board[x][y] == @board[x+1][y+1])
        return true
      end
    end
    if (x>=4 && y==5) || (x==7&&y>=3)
      if (@board[x-3][y-3] == @board[x-2][y-2])&&(@board[x-2][y-2] == @board[x-1][y-1])&&(@board[x-1][y-1] == @board[x][y])
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
    if (@board[x][y]==@board[x+1][y]) && (@board[x+1][y]==@board[x+2][y]) && (@board[x+2][y]==@board[x+3][y])
      return true
    else
      return false
    end
  end

  def horizontalLeft?(x,y)
    if (@board[x][y]==@board[x-1][y]) && (@board[x-1][y]==@board[x-2][y]) && (@board[x-2][y]==@board[x-3][y])
      return true
    else
      return false
    end
  end

  def horizontalTwoPlacesLeft?(x,y)
    if (@board[x-2][y]==@board[x-1][y]) && (@board[x-1][y]==@board[x][y]) && (@board[x][y]==@board[x+1][y])
      return true
    else
      return false
    end
  end

  def horizontalOnePlaceLeft?(x,y)
    if (@board[x-1][y]==@board[x][y]) && (@board[x][y]==@board[x+1][y]) && (@board[x+1][y]==@board[x+2][y])
      return true
    else
      return false
    end
  end
# x is columns and y is rows
# x is input and y is calculated
# x is @col and y is @row

  def verticalWin?(x,y)
    if y <= 2
      if (@board[x][y]==@board[x][y+1]) && (@board[x][y+1]==@board[x][y+2]) && (@board[x][y+2]==@board[x][y+3])
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
         #{@board[1][0]} | #{@board[2][0]} | #{@board[3][0]} | #{@board[4][0]} | #{@board[5][0]} | #{@board[6][0]} | #{@board[7][0]}
          ---------------------------------------------
         #{@board[1][1]} | #{@board[2][1]} | #{@board[3][1]} | #{@board[4][1]} | #{@board[5][1]} | #{@board[6][1]} | #{@board[7][1]}
          ---------------------------------------------
         #{@board[1][2]} | #{@board[2][2]} | #{@board[3][2]} | #{@board[4][2]} | #{@board[5][2]} | #{@board[6][2]} | #{@board[7][2]}
          ---------------------------------------------
         #{@board[1][3]} | #{@board[2][3]} | #{@board[3][3]} | #{@board[4][3]} | #{@board[5][3]} | #{@board[6][3]} | #{@board[7][3]}
          ---------------------------------------------
         #{@board[1][4]} | #{@board[2][4]} | #{@board[3][4]} | #{@board[4][4]} | #{@board[5][4]} | #{@board[6][4]} | #{@board[7][4]}
          ---------------------------------------------
         #{@board[1][5]} | #{@board[2][5]} | #{@board[3][5]} | #{@board[4][5]} | #{@board[5][5]} | #{@board[6][5]} | #{@board[7][5]}
          ---------------------------------------------

      \n"
  end

  def place_token_on_board(col, token)
    col_height = 5
    while @board[col][col_height].length!=2 && col_height >=0
      col_height -= 1
    end
    if col_height == -1
      puts "Column is full."
      pick_spot
    end
    @board[col][col_height]=token
    @row = col
    @col = col_height
  end

  def pick_spot
    @col = @next_player.prompt_user("#{@next_player.username}: Please choose a spot",
                         /^[1234567]$/, 'You must choose an available space!')
    token = @next_player == @player1 ? @player1token : @player2token
    place_token_on_board(@col.to_i, token)
    puts "#{@next_player.username} moved to #{@col}."
  end

  def take_turn
    puts "It is #{@next_player.username}'s turn."
    show_board
    pick_spot
    @next_player = @player1 == @next_player ? @player2 : @player1
    @turns -= 1
  end

  def draw?
    @turns.zero? && !winner?
  end

  def finished?
    draw? || winner?
  end

  def connect_four
    until finished?
      take_turn
    end
    show_board
  end
end
