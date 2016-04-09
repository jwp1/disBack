class ActiveIdea < ActiveRecord::Base
	belongs_to :game
  	belongs_to :idea
end
