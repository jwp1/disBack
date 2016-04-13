class Player < ActiveRecord::Base
  belongs_to :game
  has_many :active_ideas
  has_many :uber_ideas
end
