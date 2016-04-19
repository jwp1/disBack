class PlayersController < ApplicationController

  def join
    @game = Game.last
    if (@game.player_count == @game.players.count || params[:player].blank? || @game.started)
       render json: {error:true}
    elsif (@game.players.exists?(:name => params["player"]["name"]))
       render json: {duplicate:true}
    else
      @player = @game.players.new(name: params["player"]["name"])
      if @player.save
        render json: {player: @player.id, game: @game.id}
      else
        render json: {error:true}
      end
    end
  end

end
