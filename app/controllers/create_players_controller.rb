class CreatePlayersController < ApplicationController
  before_action :set_create_player, only: [:show, :update, :destroy]

  # GET /create_players
  # GET /create_players.json
  def index
    @create_players = CreatePlayer.all

    render json: @create_players
  end

  # GET /create_players/1
  # GET /create_players/1.json
  def show
    render json: @create_player
  end

  # POST /create_players
  # POST /create_players.json
  def create
    @create_player = CreatePlayer.new(create_player_params)

    if @create_player.save
      render json: @create_player, status: :created, location: @create_player
    else
      render json: @create_player.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /create_players/1
  # PATCH/PUT /create_players/1.json
  def update
    @create_player = CreatePlayer.find(params[:id])

    if @create_player.update(create_player_params)
      head :no_content
    else
      render json: @create_player.errors, status: :unprocessable_entity
    end
  end

  # DELETE /create_players/1
  # DELETE /create_players/1.json
  def destroy
    @create_player.destroy

    head :no_content
  end

  private

    def set_create_player
      @create_player = CreatePlayer.find(params[:id])
    end

    def create_player_params
      params.require(:create_player).permit(:name, :colour, :game_id)
    end
end
