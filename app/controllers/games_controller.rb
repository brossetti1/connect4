class GamesController < ApplicationController
  before_action :authenticate_user!, :only => [:destroy]
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :only => []

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  # POST /games.json
  def create
    @user = User.find(user_params)
    @game = Game.new(users: [current_user, @user], current_player_id: current_user.id)
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, alert: 'we couldnt create your game'}
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(pick_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    def set_user
      @user = @game.players
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:player_id)
    end

    def pick_params
      params.require(:column)
    end

end


# $board = {1=>["a1","a2","a3","a4","a5","a6"],
           # 2=>["b1","b2","b3","b4","b5","b6"],
           # 3=>["c1","c2","c3","c4","c5","c6"],
           # 4=>["d1","d2","d3","d4","d5","d6"],
           # 5=>["e1","e2","e3","e4","e5","e6"],
           # 6=>["f1","f2","f3","f4","f5","f6"],
           # 7=>["g1","g2","g3","g4","g5","g6"]}



