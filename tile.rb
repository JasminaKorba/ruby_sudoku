require 'colorize'

class Tile

    def self.create_tiles
        maps = ["sudoku1.txt", "sudoku2.txt", "sudoku3.txt"]
        sudoku_map = maps.sample
        values_lines = File.readlines(sudoku_map).map(&:chomp)
        values = values_lines.map do |line|
            line
                .split("")
                .map(&:to_i)
        end
        values.flatten.map { |value| self.new(value) }
    end

    attr_accessor :value
    attr_reader :given

    def initialize(value)
        @value = value
        @given = value != 0 
    end

    def override(new_value)
        @value = new_value
    end

    def to_s
        val = value.to_s
        self.given ? val.colorize(:red) : val.colorize(:light_green)
    end

end