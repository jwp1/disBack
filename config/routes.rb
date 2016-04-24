Rails.application.routes.draw do

  post '/ideas/index' => 'ideas#index'
  post '/ideas/display_winner' => 'ideas#display_winner'

  post '/uber_ideas/index' => 'uber_ideas#index'
  post '/uber_ideas/display_uber_winner' => 'uber_ideas#display_uber_winner'

  post '/games/create' => 'games#create'
  post '/games/show' => 'games#show'
  post '/games/start' => 'games#start'

  post '/player/join' => 'players#join'

end
