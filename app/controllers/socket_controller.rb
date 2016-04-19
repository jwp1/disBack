class SocketController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def player_joined
    p "WDAAAAAAAAAAAAAAAAAAAAAA"
    @game = Game.find(message[:game_id])
		p 'user connected'
		broadcast_message :player_joined, {game_id:@game.id, current_players:@game.players.count}
    p 'Websocket'
  end

  def vote
		@game = Game.find(message[:game])
    @idea = Idea.find(message[:id])
    @active_idea = @game.active_ideas.find_by_idea_id(message[:id])
    if (@game.voting_over)
      trigger_failure({error:1})
    elsif (@active_idea.player.id == message[:player])
      trigger_failure({error:2})
    else
      trigger_success({success:true})
      @active_idea.increment!(:votes)
      @idea.increment!(:popularity)
      if @game.active_ideas.where(round:@active_idea.round).sum(:votes) == @game.player_count
        broadcast_message :ideas_submitted, {game_id:@game.id}
      end
    end
  end

  def vote_uber
    @game = Game.find(message[:game])
    @idea = UberIdea.find(message[:id])
    if (@game.voting_over)
      trigger_failure({error:1})
    elsif (@idea.player.id == message[:player])
      trigger_failure({error:2})
    else
      trigger_success({success:true})
      @idea.increment!(:votes)
      if @game.uber_ideas.sum(:votes) == @game.player_count
        broadcast_message :ideas_submitted, {game_id:@game.id}
      end
    end
  end

  def submit_idea
    @game = Game.find(message[:game])
    puts "SUBMITTING**********************"
    puts message[:round]
      if (@game.voting_over)
        @idea = Idea.new(message[:idea])
        if @idea.save
          @game.active_ideas.create(round: message[:round], idea_id: @idea.id, player_id: message[:player])
          if @game.active_ideas.where(round:message[:round]).count == @game.player_count
            broadcast_message :ideas_submitted, {game_id:@game.id}
          end
          trigger_success({success:true})
        end
      else
        trigger_failure({error:true})
      end
  end

  def submit_uber_idea
    @game = Game.find(message[:game])
    if (@game.voting_over)
      @strength = 0
      for idea in Idea.where(id:@game.active_ideas.where(winner:true).pluck(:idea_id)).pluck(:name)
        @strength = @strength+1 if message[:uber_idea][:description].include?(idea)
      end
      @idea = @game.uber_ideas.new(message[:uber_idea])
      @idea.strength = @strength
      if @idea.save
        if @game.uber_ideas.count == @game.player_count
          broadcast_message :ideas_submitted, {game_id:@game.id}
        end
        trigger_success({success:true})
      end
    else
      trigger_failure({error:true})
    end
  end

  def winner_display
    @game = Game.find(message[:game_id])
    p "******************"
    puts message[:round]
    if(message[:round] < @game.rounds)
        puts "oo"
       WebsocketRails[:sockets].trigger(:next, {game_id: @game.id})
     else
        puts "pp"
       WebsocketRails[:sockets].trigger(:next, {game_id: @game.id,uber:true, winners:Idea.where(id:@game.active_ideas.where(winner:true).pluck(:idea_id))})
     end
  end
end