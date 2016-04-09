class Idea < ActiveRecord::Base
	has_many :active_ideas
	has_many :games, through :active_idea
end
