class SocketController < WebsocketRails::BaseController
  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def client_connected
		p 'user connected'
		send_message :user_info, {:user => current_user.screen_name}
  end

  def things
		p 'POOOOO'
		send_message :user_info, {:user => current_user.screen_name}
  end
end