WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6],]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, current_player = "X")
  board[location.to_i-1] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  if valid_move?(board, input)
    move(board, input, current_player(board))
  else
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end


def won?(board)
  WIN_COMBINATIONS.each do |combination|
    pos_1 = combination[0]
    pos_2 = combination[1]
    pos_3 = combination[2]

    if board[pos_1] == "X" && board[pos_2] == "X" && board[pos_3] == "X"
      return combination
    elsif board[pos_1] == "O" && board[pos_2] == "O" && board[pos_3] == "O"
      return combination
    end 
  end
  return false
end

def full?(board)
  result = board.detect{|pos| pos == " "}
  result == " " ? false : true
end

def draw?(board)
  full?(board) && !won?(board) ? true : false
end

def over?(board)
  draw?(board) || won?(board) ? true : false
end

def winner(board)
  if winning_combination = won?(board)
    if board[winning_combination[0]] == "X"
      return "X"
    elsif board[winning_combination[0]] == "O"
      return "O"
    end
  else
    return nil
  end
end

def play(board)
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end