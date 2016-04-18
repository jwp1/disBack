class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :update, :destroy, :vote]

  # GET /ideas
  # GET /ideas.json
  def index
    @game = Game.find(params[:game])
    puts params[:main]
    puts params[:round]
    puts @game.current_round
    if params[:main]
      @game.increment!(:current_round, 1)
      @game.update_attribute(:voting_over,false)
      puts "NEXT CALL"
      WebsocketRails[:sockets].trigger 'next'
    end
    @ideas = @game.ideas.references( :active_ideas ).where( active_ideas: { round: params[:round] })
    @fights = {test: "test"}
    puts "Hhhhhhhhhhhhh"
    puts @ideas.blank?
    if !@ideas.blank?
      render json: {ideas: @ideas, fights: @fights}
    else
      render json: {error: true}
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    render json: @idea
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @game = Game.find(params[:game])
      puts @game.submitting_over
      if (@game.voting_over)
        @idea = Idea.new(create_idea_params)
        if @idea.save
          @game.active_ideas.create(round: params[:round], idea_id: @idea.id, player_id: params[:player])
          render json: @idea, status: :created, location: @idea
        else
          render json: @idea.errors, status: :unprocessable_entity
        end
      else
        render json: {error: true}
      end
  end

  def vote
    @game = Game.find(params[:game])
    @idea = Idea.find(params[:id])
    @active_idea = @game.active_ideas.find_by_idea_id(params[:id])
    if (@game.voting_over)
      render json: {error: 1}
    elsif (@active_idea.player.id == params[:player])
      render json: {error: 2}
    else
      @active_idea.increment!(:votes)
      @idea.increment!(:popularity)
    end
  end

  def display_winner
    @game = Game.find(params[:game])
    @game.update_attribute(:voting_over,true)
    @game.update_attribute(:submitting_over,false)
    @ideas = @game.active_ideas.where(round:params[:round])
    puts @ideas
    @max_votes = @ideas.maximum(:votes)
    @idea = @ideas.where(votes: @max_votes).first
    if (@idea)
      puts "Success"
      puts @idea.idea_id
      @idea.update_attribute(:winner,true)
      @idea.player.increment!(:points)
      @winner = Idea.find(@idea.idea_id)
      puts @winner.id
      puts "wwwwwwwwwwww"
      @player = @idea.player
      puts @player
      puts "NEXT CALL"
      WebsocketRails[:sockets].trigger 'next'
      render json: {winner: @winner, player: @player, votes: @idea.votes}
    else
      puts "NEXT CALL"
      WebsocketRails[:sockets].trigger 'next'
      puts "Fail"
      render json: {error:true}
    end
  end

  def request_winners
    @game = Game.find(params[:game])
    @winners = Idea.where(id:Game.last.active_ideas.where(winner:true).pluck(:idea_id))
    puts @winners
    puts "YUP"
    render json: @winners
  end

  private

    def set_idea
      @idea = Idea.find(params[:id])
    end

    def idea_params
      params.require(:idea).permit(:name, :description, :picture, :categories, :temporary, :popularity)
    end

     def create_idea_params
      params.require(:idea).permit(:name, :description, :temporary)
    end
end
