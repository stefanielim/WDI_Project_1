class Move < ActiveRecord::Base
  
  attr_accessible :marker, :position, :user_id

  belongs_to :game, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: :true
  validates :game_id, presence: :true
  validates :position, presence: true
  validates :position, numericality: true

  validate :is_users_turn 
  validate :position_in_board
  validate :player_validity
  validate :empty_position?
  validate :check_finished?

  before_create :set_marker
  # after_create :initialize_computer_play?
  after_create :update_winner_id_if_game_won
  after_create :update_game_status_if_finished
 
  # after_create :tell_game_to_check_for_finished

  private 

  def set_marker
    user_id == game.player_1.id ? self.marker = "X" : self.marker = "O"
  end

  def is_users_turn
    errors.add(:player, "Sorry, it's not your turn") unless game.whose_turn == user 
  end

  def empty_position?
    errors.add(:position, "Sorry, that position has already been taken") unless !game.get_all_positions.include? position
  end

  def position_in_board
    errors.add(:position, "Sorry that position is not within the grid") unless (position > 0 && position <= game.max_moves)
  end

  def player_validity
    errors.add(:player, "Sorry that is not a valid player for this game") unless game.find_players.include? self.user
  end

  def check_finished?
    errors.add(:base, "Sorry, the game has finished") unless !game.finished?
  end

  def update_game_status_if_finished
    game.change_outcome_if_finished
  end

  def update_winner_id_if_game_won
    game.set_winner_id_if_win
  end

  # def initialize_computer_play?
  #   game.computer_play if game.player_2_id == 9
  # end

  # def tell_game_to_check_for_finished
  #   game.check_for_finished!
  # end



end

