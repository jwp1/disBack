require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  setup do
    @idea = ideas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ideas)
  end

  test "should create idea" do
    assert_difference('Idea.count') do
      post :create, idea: { categories: @idea.categories, description: @idea.description, name: @idea.name, picture: @idea.picture, popularity: @idea.popularity, temporary: @idea.temporary }
    end

    assert_response 201
  end

  test "should show idea" do
    get :show, id: @idea
    assert_response :success
  end

  test "should update idea" do
    put :update, id: @idea, idea: { categories: @idea.categories, description: @idea.description, name: @idea.name, picture: @idea.picture, popularity: @idea.popularity, temporary: @idea.temporary }
    assert_response 204
  end

  test "should destroy idea" do
    assert_difference('Idea.count', -1) do
      delete :destroy, id: @idea
    end

    assert_response 204
  end
end
