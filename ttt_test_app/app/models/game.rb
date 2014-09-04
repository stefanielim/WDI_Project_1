require 'set'

class Game < ActiveRecord::Base
  
  attr_accessible :grid_size, :player_1_id, :player_2_id

  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  belongs_to :winner, class_name: 'User'
  has_many :moves, dependent: :destroy

  validates :player_1_id, presence: true
  validates :player_2_id, presence: true
  validates :grid_size, presence: true

  validate :different_players
  validate :valid_grid_size

  before_create :set_outcome

  WINS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def max_moves
    grid_size ** 2
  end

  def whose_turn
    return player_1 if moves.empty?
    moves.last.user == player_1 ? player_2 : player_1
  end

  def get_all_positions
    moves.map(&:position)
  end

  def find_players
    [player_1, player_2]
  end

  # Find all the moves of a player within a game
  # Happens after a move is made by a player
  def last_player_moves
    moves.last.user.moves.where(game_id: self.id) if moves.present?
  end

  def last_player_positions
    last_player_moves.map(&:position) if last_player_moves.present?
  end

  # Input those moves into a method that would check if any of the win conditions are a subset of the players moves

  # positions = game.moves.where(user_id: p1.id).pluck(:position)

  def won?
    return false if !last_player_positions
    win = false
    winning_moves.each do |array|
      if array.to_set.subset?(last_player_positions.to_set)
        win = true
      end
    end
    win
  end

  def draw?
    moves.count == max_moves && !won?
  end

  def finished?
    won? || draw?  
  end

  def set_winner_id_if_win
    reload
    winner_id = moves.last.user.id and save! if won?
  end

  def change_outcome_if_finished
    reload
    if finished?
      self.outcome = "Finished" 
      save!
    elsif player_2_id == 9
      computer_play
    end
  end

  # def check_for_finished!
  #   # TODO: add some way of tracking scores for users - here might be a good place
  #   puts 'game is finished' if finished?
  # end

  def computer_play
    moves.create!(user_id: 9,  position: ((1..9).to_a - moves.map(&:position)).sample) if whose_turn.id == 9
  end

  def winning_rows
    (0...grid_size**2).map {|x| x + 1}.each_slice(grid_size).to_a
  end

  def winning_columns
    (1..grid_size).map { |i| (0...grid_size).map {|x| grid_size*x + i} }
  end

  def winning_diagonal_lr
    (0...grid_size).map {|x| (grid_size + 1)*x + 1 }
  end
  
  def winning_diagonal_rl
    (0...grid_size).map {|x| (grid_size - 1)*x + grid_size }
  end

  def winning_moves
    winning_rows + winning_columns + [winning_diagonal_lr] + [winning_diagonal_rl]
  end

  private
  def different_players
    errors.add(:player_2, "has already been chosen") unless player_2 != player_1
  end

  def valid_grid_size
    errors.add(:base, "Please choose 3 as the grid size (more in next version!)") unless grid_size == 3
  end

  def set_outcome
    self.outcome ||= "In progress"
  end

end
