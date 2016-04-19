class UberIdeasController < ApplicationController

  def index
    @game = Game.find(params[:game])
    if params[:main]
      @game.increment!(:current_round, 1)
      @game.update_attribute(:voting_over,false)
      @ideas = @game.uber_ideas
      if !@ideas.blank?
        WebsocketRails[:sockets].trigger(:next, {game_id:@game.id, uber_ideas: @ideas})
        render json: {game_id:@game.id, uber_ideas: @ideas}
      else
        WebsocketRails[:sockets].trigger(:next, {game_id:@game.id, error: true})
        render json: {error: true}
      end
    end
  end


  def display_uber_winner
    @game = Game.find(params[:game])
    @players = @game.players
    @ideas = @game.uber_ideas
    @max_votes = @ideas.maximum(:votes)
    @idea = @ideas.where(votes: @max_votes).first
    if (@idea)
      @idea.player.increment!(:points)
      @player = @idea.player
      WebsocketRails[:sockets].trigger(:next, {game_id:@game.id})
      render json: {winner: @idea, player: @player, players: @players}
    else
      render json: {error:true, players: @players}
    end
  end
end