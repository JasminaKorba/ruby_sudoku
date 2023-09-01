class HumanPlayer

    def get_player_input_pos
        pos = gets
                .chomp
                .split(" ")
        pos.map(&:to_i)
    end

    def get_player_input_value
        gets
            .chomp
            .to_i
    end

    def prompt_pos
        puts "Select a position. (e.g. 1 3)"
    end

    def prompt_val
        puts "Select a value from 1 to 9  (e.g. 3)"
    end

end