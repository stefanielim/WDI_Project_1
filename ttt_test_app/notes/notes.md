Plan
====

## User
name:string email:string password_digest:string
has_many :games
has_many :moves
has_many :results
 
## Game
grid_size:integer player_1:references player_2:references status:integer 
has_many :moves
has_many :results
belongs_to :player_1, class_name: 'User'
belongs_to :player_2, class_name: 'User'

## Move
user:references game:references position:integer marker:string
belongs_to :game
belongs_to :user

## Result
winner:references game:references
belongs_to :game
belongs_to :user



Other
=====

1 2 3
4 5 6
7 8 9

grid_size = 3
max_moves = width*2
possible_moves = calculation? = 1 2 3 4 5 6 7 8 9


WINS = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]


# All moves from user1 in game
# All moves from user2 in game

status:
  1: finished
  0: ongoing


