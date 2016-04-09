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
    render json: {game:Game.last, questions: Question.all}
  end

  # POST /games
  # POST /games.json
  def create
    #puts "-----------"
    Question.destroy_all
    questions = params["game"]["questions"]
    params["game"].delete("questions")
    #puts game_params
    puts questions
    @game = Game.new(game_params)
    unless questions.nil?
      questions.each do |key, value|
        @game.questions.new(name:value, round: key.to_i+1)
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
      params.require(:game).permit(:name, :rounds, :input_timer, :battle_timer, :questions)
    end

end
