require_relative "tile.rb"
require 'colorize'

class Board

    attr_accessor :rows

    def initialize
        @rows = Array.new(9) { Array.new(9) }
        populate
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, value)
        row, col = pos
        rows[row][col] = value
    end

    def compare_diagonal(range_row, range_col, val)
        range_row
            .to_a
            .each do |row_i|
                range_col
                    .to_a
                    .each do |col_i|
                        return true if @rows[row_i][col_i].value == val
                    end
            end
        false
    end

    def double_in_col?(pos, val)
        row, col = pos
        @rows.each_index do |row_i|
            return true if @rows[row_i][col].value == val
        end
        false
    end

    def double_diagonal?(pos, val)
        row, col = pos 
        range_row = nil
        range_col = nil

        if (0..2) === row
            range_row = (0..2)
        elsif (3..5) === row
            range_row = (3..5)
        elsif (6..8) === row
            range_row = (6..8)
        end
        
        if (0..2) === col
            range_col = (0..2)
        elsif (3..5) === col
            range_col = (3..5)
        elsif (6..8) === col
            range_col = (6..8)
        end

        compare_diagonal(range_row, range_col, val)
    end 

    def double_in_row?(pos, val)
        row, col = pos
        @rows[row].any? { |i| i.value == val }
    end

    def is_given?(pos)
        row, col = pos
        @rows[row][col].given
    end

    def override(pos, val)
        row, col = pos
        @rows[row][col].override(val)
    end

    def populate 
        values = Tile.create_tiles 
        rows.each_index do |row_i|
            rows[row_i].each_index do |col_i|
                self[[row_i, col_i]] = values.shift
            end
        end
    end

    def render
        x_axis = (0...rows.length)
            .to_a
            .join(" ")
        values = ""

        rows.each_index do |row_i|
            row = ""

            rows[row_i].each_index do |col_i|
                value = self[[row_i, col_i]].to_s
                row += "#{value}\s"
            end

            values += "#{row_i}\s" + "#{row}\n"
        end

        puts "\s\s#{x_axis}\n" + "#{values}"
    end

    def solved?
        @rows.flatten.none? { |tile| tile.value == 0 }
    end

end 


