class UberIdeasController < ApplicationController
  before_action :set_uber_idea, only: [:show, :update, :destroy]

  # GET /uber_ideas
  # GET /uber_ideas.json
  def index
    @game = Game.find(params[:game])
    puts params[:main]
    puts params[:round]
    puts @game.current_round
    if params[:main]
      @game.increment!(:current_round, 1)
      @game.update_attribute(:voting_over,false)
    end
    if(@game.current_round-1 == params[:round])
      @ideas = @game.uber_ideas
      puts "Hhhhhhhhhhhhh"
      puts @ideas.blank?
      if !@ideas.blank?
        render json: {uber_ideas: @ideas}
      else
        render json: {error: true}
      end
    else
      render json: {error: true}
    end
  end

  # GET /uber_ideas/1
  # GET /uber_ideas/1.json
  def show
    render json: @uber_idea
  end


  def vote
    @game = Game.find(params[:game])
    if !@game.voting_over
      @idea = UberIdea.find(params[:id])
      if(@active_idea.player.id != params[:player])
        @idea.increment!(:votes)
        render json: {error: 0}
      else
        render json: {error: 1}
      end
    else
      render json: {error: 2}
    end
  end

  # POST /uber_ideas
  # POST /uber_ideas.json

  def display_uber_winner
    @game = Game.find(params[:game])
    @ideas = @game.uber_ideas
    puts @ideas
    puts "wwww"
    @max_votes = @ideas.maximum(:votes)
    @game.update_attribute(:voting_over,true)
    @idea = @ideas.where(votes: @max_votes).first
    if (@idea)
      puts "wwwwwwwwwwww"
      @idea.player.increment!(:points)
      @players = @game.players
      @player = @idea.player
      puts @player
      puts "^^^"

      render json: {winner: @idea, player: @player, players: @players, votes: @idea.votes}
    else
      render json: {error:true}
    end
  end

  def create
    @game = Game.find(params[:game])
    @strength = 0
    for idea in Idea.where(id:@game.active_ideas.where(winner:true).pluck(:idea_id)).pluck(:name)
      @strength = @strength+1 if uber_idea_params[:description].include?(idea)
    end
    puts params[:player_id]
    puts @game.uber_ideas.exists?(:player_id => uber_idea_params[:player_id])
    if (!@game.uber_ideas.exists?(:player_id => uber_idea_params[:player_id]))
      @idea = @game.uber_ideas.new(uber_idea_params)
      @idea.strength = @strength
      if @idea.save
        render json: @idea, status: :created, location: @idea
      else
        render json: @idea.errors, status: :unprocessable_entity
      end
    else
      render json: {error: true}
    end
  end

  # PATCH/PUT /uber_ideas/1
  # PATCH/PUT /uber_ideas/1.json
  def update
    @uber_idea = UberIdea.find(params[:id])

    if @uber_idea.update(uber_idea_params)
      head :no_content
    else
      render json: @uber_idea.errors, status: :unprocessable_entity
    end
  end

  # DELETE /uber_ideas/1
  # DELETE /uber_ideas/1.json
  def destroy
    @uber_idea.destroy

    head :no_content
  end

  private

    def set_uber_idea
      @uber_idea = UberIdea.find(params[:id])
    end

    def uber_idea_params
      params.require(:uber_idea).permit(:game_id, :player_id, :description)
    end
end
