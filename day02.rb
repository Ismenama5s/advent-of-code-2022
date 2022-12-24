MOVES = [:ROCK, :PAPER, :SCISSORS]
CHARS_TO_MOVES = 'ABCXYZ'.chars.zip(MOVES + MOVES).to_h
SCORES = MOVES.zip(1..3).to_h
WIN = 6
DRAW = 3
LOSE = 0
ROUNDS = File.readlines('day02.txt')

# Part 1

def outcome(my_move, his_move)
    return DRAW if my_move == his_move

    my_index = MOVES.index(my_move)
    MOVES[my_index - 1] == his_move ? WIN : LOSE
end

score = ROUNDS.sum do |round|
    his_move, _, my_move = round.chars.map { |char| CHARS_TO_MOVES[char] }
    outcome(my_move, his_move) + SCORES[my_move]
end
puts score

# Part 2

INSTRUCTIONS = { X: LOSE, Y: DRAW, Z: WIN }
score2 = ROUNDS.sum do |round|
    his_move = CHARS_TO_MOVES[round[0]]
    i_need_to = INSTRUCTIONS[round[2].to_sym]
    
    my_move = case i_need_to
    when LOSE then MOVES[MOVES.index(his_move) - 1]
    when WIN then (MOVES + MOVES)[MOVES.index(his_move) + 1]
    when DRAW then his_move
    else raise "wtf is #{i_need_to}"
    end
    outcome(my_move, his_move) + SCORES[my_move]
end
puts score2