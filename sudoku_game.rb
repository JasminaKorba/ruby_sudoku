require_relative "board.rb"
require_relative "human_player.rb"

class SudokuGame

    attr_accessor :last_pos
    attr_reader :board, :player

    def initialize(player)
        @board = Board.new
        @player = player
        @last_pos = nil
    end

    def compare(pos, val)
       is_given?(pos) && double_in_row?(pos, val) && double_in_col?(pos, val) && double_diagonal?(pos, val)
    end

    def double_diagonal?(pos, val)
        if board.double_diagonal?(pos, val)
           puts "Value can not double in a 3x3 square. Try again..."
           sleep(3)
           return false 
       end
       true
    end

    def double_in_col?(pos, val)
        if board.double_in_col?(pos, val)
           puts "Value can not double in a column. Try again..."
           sleep(3)
           return false 
       end
       true
    end

    def double_in_row?(pos, val)
        if board.double_in_row?(pos, val)
           puts "Value can not double in a row. Try again..."
           sleep(3)
           return false
       end
       true
    end

    def get_player_input_pos
        pos = nil
        until pos && valid_pos?(pos)
            player.prompt_pos
            pos = player.get_player_input_pos
        end
        pos
    end

    def get_player_input_value
        value = nil
        until value && valid_value?(value)
            player.prompt_val
            value = player.get_player_input_value
        end
        value
    end

    def is_given?(pos)
        if board.is_given?(pos)
           puts "You can not change red (given) position. Try again..."
           sleep(3)
           return false
       end
       true
    end

    def play
        welcome
        until board.solved? 
            system("clear")
            board.render
            puts "Last position : #{last_pos.join(" ")}" if last_pos != nil
            pos = get_player_input_pos 
            value = get_player_input_value
            next if !compare(pos, value)
            @last_pos = pos
            board.override(pos, value)
            sleep(2)
        end
        puts "\nCongratulations! You won!"
    end

    def valid_pos?(pos)
        return true if pos.length == 2 && pos.all? { |i| (0..8) === i}
        puts "It is not a valid position. Try again..."
        false
    end

    def valid_value?(value)
        return true if (1..9) === value
        puts "It is not a valid value."
        false
    end

    def welcome
        system("clear")
        puts "Lets start the game...\n\n"
        sleep(2)
        puts "Good luck!\n\n"
        sleep(2)
    end

end

if $PROGRAM_NAME == __FILE__
    game = SudokuGame.new(HumanPlayer.new)
    game.play
end