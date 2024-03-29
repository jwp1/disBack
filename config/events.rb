WebsocketRails::EventMap.describe do
  subscribe :player_joined, :to => SocketController, :with_method => :player_joined
  subscribe :vote, :to => SocketController, :with_method => :vote
  subscribe :vote_uber, :to => SocketController, :with_method => :vote_uber
  subscribe :submit_idea, :to => SocketController, :with_method => :submit_idea
  subscribe :submit_uber_idea, :to => SocketController, :with_method => :submit_uber_idea
  subscribe :winner_display, :to => SocketController, :with_method => :winner_display
  # You can use this file to map incoming events to controller actions.
  # One event can be mapped to any number of controller actions. The
  # actions will be executed in the order they were subscribed.
  #
  # Uncomment and edit the next line to handle the client connected event:
  #   subscribe :client_connected, :to => Controller, :with_method => :method_name
  #
  # Here is an example of mapping namespaced events:
  #   namespace :product do
  #     subscribe :new, :to => ProductController, :with_method => :new_product
  #   end
  # The above will handle an event triggered on the client like `product.new`.
end
