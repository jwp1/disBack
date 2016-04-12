class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  # GET /players
  # GET /players.json
  def index
    @players = Player.all

    render json: @players
  end

  # GET /players/1
  # GET /players/1.json
  def show
    render json: @player
  end

  def join
    params["player"]["colour"] = "%06x" % (rand * 0xffffff)
    @game = Game.last

    if (@game.player_count == @game.players.count)
       render json: {error:true}
    else
      @player = @game.players.new(player_params)
      @player.save
      render json: {player: @player.id}
    end
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /players/1
  # PATCH/PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    if @player.update(player_params)
      head :no_content
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player.destroy

    head :no_content
  end

  private

    def set_player
      @player = Player.find(params[:id])
    end

    def player_params
      params.require(:player).permit(:name, :colour, :game_id)
    end
end
