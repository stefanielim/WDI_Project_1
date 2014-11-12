require 'pry-byebug'
require 'matrix'

board = Matrix.build(3) {|row, col| 1 + 2 * row + col }

binding.pry

board = {
  a1: "",
  a2: "",
  a3: "",
  b1: "",
  b2: "",
  b3: "",
  c1: "",
  c2: "",
  c3: ""
}

(1..3).each do
  print "Player 1 move - position: "
  position = gets.chomp.to_sym
  print "Player 1 move - marker: "
  marker = gets.chomp

  board[position] = marker

  print "Player 2 move - position: "
  position =  gets.chomp.to_sym
  print "Player 2 move - marker: "
  marker =  gets.chomp

  board[position] = marker

  print "Player 1 move - position: "
  position = gets.chomp.to_sym
  print "Player 1 move - marker: "
  marker = gets.chomp

  board[position] = marker
end

puts board















