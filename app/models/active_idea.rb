class ActiveIdea < ActiveRecord::Base
	belongs_to :game
  	belongs_to :idea
  	belongs_to :player
end
