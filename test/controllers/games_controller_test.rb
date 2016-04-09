require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { battle_timer: @game.battle_timer, input_timer: @game.input_timer, name: @game.name, rounds: @game.rounds }
    end

    assert_response 201
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should update game" do
    put :update, id: @game, game: { battle_timer: @game.battle_timer, input_timer: @game.input_timer, name: @game.name, rounds: @game.rounds }
    assert_response 204
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_response 204
  end
end
