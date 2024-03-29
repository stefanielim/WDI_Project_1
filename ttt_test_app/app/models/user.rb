class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :name, :email, :password, :password_confirmation

  validates :password, presence: true, on: :create
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  has_many :games, dependent: :destroy
  has_many :moves, dependent: :destroy

  def role?(role_to_compare)
    self.role.to_s == role_to_compare.to_s
  end

  def games
    Game.where("games.player_1_id = :id or games.player_2_id = :id", id: id )
  end

  def games_won
    Game.where("games.winner_id = :id and games.outcome = 'Finished'", id: id)
  end

  def games_lost
    games - games_won - games_draw - games_in_progress
  end

  def number_of_games_won
    games_won.count
  end

  def number_of_games_lost
    games_lost.count
  end

  def games_draw
    self.games.where(winner_id: nil).where(outcome: "Finished")
  end

  def number_of_games_draw
    games_draw.count
  end

  def games_in_progress
    games.where(outcome: 'In progress')
  end

  def number_of_games_in_progress
    games_in_progress.count
  end
end
