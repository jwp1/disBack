class Game < ActiveRecord::Base
	has_many :questions
	has_many :active_ideas
	has_many :ideas, through: :active_ideas
end
