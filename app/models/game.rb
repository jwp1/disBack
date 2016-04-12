class Game < ActiveRecord::Base
	has_many :questions
	has_many :active_ideas
	has_many :players
	has_many :ideas, through: :active_ideas

	after_initialize :set_current_round

  def set_current_round
    self.current_round = 0 if self.new_record?
  end
end
