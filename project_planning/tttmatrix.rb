require 'pry-byebug'
require 'matrix'

class Matrix

  def []=(i, j, x)
    @rows[i][j] = x
  end

end 

def create_board
  rows = Matrix.empty(3,0)
  columns = Matrix.empty(0,3)
  @board = rows * columns
end

def get_board_rows
  x = 0
  @rows = Array.new
  while x < 3 do
    @rows << @board.row(x).to_a
    x += 1
  end
  @rows
end

def get_board_columns
  x = 0
  @columns = Array.new
  while x < 3 do
    @columns << @board.column(x).to_a
    x += 1
  end
  @columns
end

def get_diagonal_lr
  @diagonal_lr = @board.each(:diagonal).to_a
end

def get_diagonal_rl
  i = 0
  j = 2
  @diagonal_rl = Array.new
  
  while i < 3 do
    @diagonal_rl << @board[i,j]
    i += 1
    j -= 1
  end
  @diagonal_rl

end

def equal_values?(array)
  return true if array.each { |element| element == array[0]}
end



def array_win?(multid_array)
  if !(multid_array.include? [0,0,0]) && multid_array.map {|array| equal_values?(array) }
    return true 
  else
    return false
  end
end

def game_win_condition
  if array_win?(get_board_rows) || array_win?(get_board_columns) || array_win?(get_diagonal_lr) || array_win?(get_diagonal_rl)
    puts "you win!"
  else
    puts "next move"
  end
end

def input_to_matrix_position(input)
  input_array = input.split(",")
  matrix_position = input_array.map {|n| n.to_i}
end

def switch_turns(turn)  
  if turn == :x
    :o
  else
    :x
  end
end

create_board

turn = :x

(1..9).each do
  print "Player #{turn.to_s.upcase}, where would you like to put your marker? "
  position = gets.chomp
  
  x = input_to_matrix_position(position)
  row = x[0]
  column = x[1]
  @board[row, column] = turn
  turn = switch_turns(turn)
  binding.pry
  game_win_condition
end





binding.pry
