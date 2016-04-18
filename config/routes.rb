Rails.application.routes.draw do

  resources :uber_ideas, except: [:new, :edit]
  resources :players, except: [:new, :edit]
  resources :create_players, except: [:new, :edit]
  resources :games, except: [:new, :edit]
  resources :questions, except: [:new, :edit]
  resources :ideas, except: [:new, :edit]
  post '/test' => 'application#test'
  post '/ideas/create' => 'ideas#create'
  post '/ideas/index' => 'ideas#index'
  post '/ideas/vote' => 'ideas#vote'
  post '/ideas/request_winners' => 'ideas#request_winners'
  post '/ideas/decide_winner' => 'ideas#decide_winner'
  post '/ideas/winner_decided' => 'ideas#winner_decided'
  post '/ideas/display_winner' => 'ideas#display_winner'
  post '/ideas/destroy_all' => 'ideas#destroy_all'

  post '/uber_ideas/create' => 'uber_ideas#create'
  post '/uber_ideas/index' => 'uber_ideas#index'
  post '/uber_ideas/display_uber_winner' => 'uber_ideas#display_uber_winner'
  post '/uber_ideas/vote' => 'uber_ideas#vote'

  post '/games/create' => 'games#create'
  post '/games/show' => 'games#show'
  post '/games/start' => 'games#start'
  post '/games/round_over' => 'games#round_over'

  post '/player/join' => 'players#join'

  post '/games/current_players' => 'games#current_players'

  post '/questions/index' => 'questions#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
