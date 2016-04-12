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
    end
    if(@game.current_round-1 == params[:round])
      @ideas = @game.ideas.references( :active_ideas ).where( active_ideas: { round: params[:round] })
      @fights = {test: "test"}
      puts "Hhhhhhhhhhhhh"
      puts @ideas.blank?
      if !@ideas.blank?
        render json: {ideas: @ideas, fights: @fights}
      else
        render json: {error: true}
      end
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
    puts @game.active_ideas.exists?(:player_id => params[:player], :round => params[:round])
    if (!@game.active_ideas.exists?(:player_id => params[:player], :round => params[:round]) && !params[:player].blank?)
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

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    @idea = Idea.find(params[:id])

    if @idea.update(idea_params)
      head :no_content
    else
      render json: @idea.errors, status: :unprocessable_entity
    end
  end

  def vote
    @idea = Idea.find(params[:id])
    @idea.active_ideas.find_by_idea_id(params[:id]).increment!(:votes)
    @idea.increment!(:popularity)
  end

  def display_winner
    @game = Game.find(params[:game])
    @ideas = @game.active_ideas.where(round:params[:round])
    puts @ideas
    @max_votes = @ideas.maximum(:votes)
    @idea = @ideas.where(votes: @max_votes).first
    if (@idea)
      puts @idea.idea_id
      @idea.player.increment!(:points)
      @winner = Idea.find(@idea.idea_id)
      puts @winner.id
      puts "wwwwwwwwwwww"
      @player = @idea.player
      puts @player

      render json: {winner: @winner, player: @player, votes: @idea.votes}
    else
      render json: {error:true}
    end
  end

  def decide_winner
    @game = Game.find(params[:game])
    @ideas = @game.active_ideas.where(round:params[:round])
    @max_votes = @ideas.maximum(:votes)
    @idea = @ideas.where(votes: @max_votes).first.update_attribute(:winner,true)
    puts "----"

    render json: @winner
  end

  def request_winners
    @game = Game.find(params[:game])
    @winners = Idea.where(id:Game.last.active_ideas.where(winner:true).pluck(:idea_id))
    puts @winners
    puts "YUP"
    render json: @winners
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy

    head :no_content
  end

  def winner_decided
    @game = Game.find(params[:game])
    puts params[:round]
    if(@game.active_ideas.exists?(winner:true,round:params[:round]-1))
      render json: {error:false}
    else
      render json: {error:true}
    end
  end

   def destroy_all
    ActiveIdea.destroy_all

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
