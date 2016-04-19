class IdeasController < ApplicationController

  def index
    @game = Game.find(params[:game])
    if params[:main]
      @game.increment!(:current_round, 1)
      @game.update_attribute(:voting_over,false)
      @ideas = @game.ideas.references( :active_ideas ).where( active_ideas: { round: params[:round] })
      if !@ideas.blank?
        WebsocketRails[:sockets].trigger(:next, {game_id:@game.id, ideas: @ideas})
        render json: {game_id:@game.id, ideas: @ideas}
      else
        WebsocketRails[:sockets].trigger(:next, {game_id:@game.id, error: true})
        render json: {error:true}
      end
    end
  end

  def display_winner
    @game = Game.find(params[:game])
    @game.update_attribute(:voting_over,true)
    @game.update_attribute(:submitting_over,false)
    @ideas = @game.active_ideas.where(round:params[:round])
    @max_votes = @ideas.maximum(:votes)
    @idea = @ideas.where(votes: @max_votes).first
    if (@idea)
      @idea.update_attribute(:winner,true)
      @idea.player.increment!(:points)
      @winner = Idea.find(@idea.idea_id)
      @player = @idea.player
      if(params[:round]+1 <= @game.rounds)
        WebsocketRails[:sockets].trigger(:next, {game_id: @game.id})
      else
        WebsocketRails[:sockets].trigger(:next, {game_id: @game.id,uber:true, winners:Idea.where(id:@game.active_ideas.where(winner:true).pluck(:idea_id))})
      end
      render json: {winner: @winner, player: @player, votes: @idea.votes}
    else
      if(params[:round]+1 <= @game.rounds)
        WebsocketRails[:sockets].trigger(:next, {game_id: @game.id})
      else
        WebsocketRails[:sockets].trigger(:next, {game_id: @game.id,uber:true, winners:Idea.where(id:@game.active_ideas.where(winner:true).pluck(:idea_id))})
        render json: {winner: @winner, player: @player}
      end
      render json: {error:true}
    end
  end

end
