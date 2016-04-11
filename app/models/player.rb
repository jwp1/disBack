class Player < ActiveRecord::Base
  belongs_to :game
  has_many :active_ideas
end
