require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should create question" do
    assert_difference('Question.count') do
      post :create, question: { game_id: @question.game_id, name: @question.name, round: @question.round }
    end

    assert_response 201
  end

  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should update question" do
    put :update, id: @question, question: { game_id: @question.game_id, name: @question.name, round: @question.round }
    assert_response 204
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_response 204
  end
end
