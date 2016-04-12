class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :update, :destroy, :vote]

  # GET /ideas
  # GET /ideas.json
  def index
    @ideas = Game.find(params[:game]).ideas.references( :active_ideas ).where( active_ideas: { round: params[:round] })
    @fights = {test: "test"}
    

    render json: {ideas: @ideas, fights: @fights}
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
    if (@game.active_ideas.exists?(:player_id => params[:player], :round => params[:round]) && !params[:player].blank?)
      @idea = Idea.new(create_idea_params)
      if @idea.save
        @game.active_ideas.create(round: params[:round], idea_id: @idea.id)
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
    @idea.active_ideas.find_by_game_id(params[:game]).increment!(:votes)
    @idea.increment!(:popularity)
  end

  def display_winner
    @game = Game.find(params[:game])
    @ideas = @game.active_ideas.where(round:params[:round])
    @winner = Idea.find(@ideas.order("votes DESC").first.idea_id)
    @game.increment(:current_round, 1)
    render json: @winner
  end

  def decide_winner
    @game = Game.find(params[:game])
    @ideas = @game.active_ideas.where(round:params[:round])
    ActiveIdea.find_by_idea_id(@ideas.order("votes DESC").first.idea_id).update_attribute(:winner,true)
    puts "----"

    render json: @winner
  end

  def request_winner
    @game = Game.find(params[:game])
    if @idea_ref = @game.active_ideas.find_by_round_and_winner(params[:round], true)
      @winner = Idea.find(@idea_ref.idea_id)
      render json: @winner
    else
      render json: {error:true}
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy

    head :no_content
  end

   def destroy_all
    Idea.destroy_all

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
