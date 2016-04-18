class GamesController < ApplicationController

  def show
    @game = Game.last
    if(params["main"] && @game.started)
      render json: {error:true}
    else
      render json: {game:Game.last, questions: Game.last.questions.all}
    end
  end

  def start
    @game = Game.find(params[:game])
    @game.update_attribute(:started, true)
    if (@game.player_count == @game.players.count)
      WebsocketRails[:sockets].trigger 'next'
      @game.increment!(:current_round, 1)
    end
  end

  def current_players
    @game = Game.find(params[:game])
    @players = @game.players
    render json: {players: @players}
  end

  # POST /games
  # POST /games.json
  def create
    if (params["game"]["rounds"].to_i > 0 && params["game"]["input_timer"].to_i > 9 && params["game"]["battle_timer"].to_i > 4 && params["game"]["player_count"].to_i > 0)
      questions = params["game"]["questions"]
      params["game"].delete("questions")
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
    else
      render json: {error: true}
    end
  end


  private

    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:name, :rounds, :input_timer, :battle_timer, :questions, :player_count)
    end

end
