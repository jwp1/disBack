require 'test_helper'

class UberIdeasControllerTest < ActionController::TestCase
  setup do
    @uber_idea = uber_ideas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:uber_ideas)
  end

  test "should create uber_idea" do
    assert_difference('UberIdea.count') do
      post :create, uber_idea: { description: @uber_idea.description, game_id: @uber_idea.game_id, player_id: @uber_idea.player_id, strength: @uber_idea.strength, votes: @uber_idea.votes }
    end

    assert_response 201
  end

  test "should show uber_idea" do
    get :show, id: @uber_idea
    assert_response :success
  end

  test "should update uber_idea" do
    put :update, id: @uber_idea, uber_idea: { description: @uber_idea.description, game_id: @uber_idea.game_id, player_id: @uber_idea.player_id, strength: @uber_idea.strength, votes: @uber_idea.votes }
    assert_response 204
  end

  test "should destroy uber_idea" do
    assert_difference('UberIdea.count', -1) do
      delete :destroy, id: @uber_idea
    end

    assert_response 204
  end
end
