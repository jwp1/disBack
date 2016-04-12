class Player < ActiveRecord::Base
  belongs_to :game
  has_many :active_ideas
  has_many :uber_ideas

  after_initialize :set_points

  def set_points
    self.points = 0 if self.new_record?
  end
end
