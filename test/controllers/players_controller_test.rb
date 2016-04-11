require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, player: { colour: @player.colour, game_id: @player.game_id, name: @player.name }
    end

    assert_response 201
  end

  test "should show player" do
    get :show, id: @player
    assert_response :success
  end

  test "should update player" do
    put :update, id: @player, player: { colour: @player.colour, game_id: @player.game_id, name: @player.name }
    assert_response 204
  end

  test "should destroy player" do
    assert_difference('Player.count', -1) do
      delete :destroy, id: @player
    end

    assert_response 204
  end
end
