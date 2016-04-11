require 'test_helper'

class CreatePlayersControllerTest < ActionController::TestCase
  setup do
    @create_player = create_players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:create_players)
  end

  test "should create create_player" do
    assert_difference('CreatePlayer.count') do
      post :create, create_player: { colour: @create_player.colour, game_id: @create_player.game_id, name: @create_player.name }
    end

    assert_response 201
  end

  test "should show create_player" do
    get :show, id: @create_player
    assert_response :success
  end

  test "should update create_player" do
    put :update, id: @create_player, create_player: { colour: @create_player.colour, game_id: @create_player.game_id, name: @create_player.name }
    assert_response 204
  end

  test "should destroy create_player" do
    assert_difference('CreatePlayer.count', -1) do
      delete :destroy, id: @create_player
    end

    assert_response 204
  end
end
