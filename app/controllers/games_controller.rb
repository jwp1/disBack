class GamesController < ApplicationController
  before_action :set_game, only: [:update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    render json: @games
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.last
    if (@game.current_round == 0 && !params[:main])
      render json: {error:true}
    else
      render json: {game:Game.last, questions: Game.last.questions.all}
    end
  end

  def round_over
    @game = Game.find(params[:game])
    if(@game.current_round == params[:round])
      render json: {error:false}
    else
      render json: {error:true}
    end
  end

  def start
    @game = Game.find(params[:game])
    if (@game.player_count == @game.players.count)
      puts "YES"
      @game.increment!(:current_round, 1)
    end
  end

  def current_players
    #@game = Game.find(params[:id])
    @game = Game.last
    @players = @game.players
    render json: {players: @players}
  end

  # POST /games
  # POST /games.json
  def create
    #puts "-----------"
    Question.destroy_all
    questions = params["game"]["questions"]
    params["game"].delete("questions")
    params["game"]["current_round"] = 0
    #puts game_params
    puts questions
    @game = Game.new(game_params)
    unless questions.nil?
      questions.each do |key, value|
        unless value.blank?
          @game.questions.new(name:value, round: key.to_i+1)
        end
      end
    end
    if @game.save
      render json: @game, status: :created, location: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      head :no_content
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy

    head :no_content
  end

  private

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:name, :rounds, :input_timer, :battle_timer, :questions, :player_count)
    end

end
