class Game < ActiveRecord::Base
	has_many :questions
	has_many :active_ideas
	has_many :players
	has_many :uber_ideas
	has_many :ideas, through: :active_ideas

	after_initialize :set_defs

  def set_defs
    self.current_round = 0 if self.new_record?
    self.submitting_over = false if self.new_record?
    self.voting_over = true if self.new_record?
    self.game_over = false if self.new_record?
  end
end
