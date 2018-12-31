require "colorize"
require 'byebug'
class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
  end

  def render
    until false
      system("clear")
      board.rows.each_with_index do |row,i|
        row.each_with_index do |col,j|
          pos = [i,j]
          symbol = board[pos].symbol
          color = board[pos].color
          unless pos == cursor.pos
            if cursor.selected != nil && cursor.selected.pos == pos
              print print " #{symbol} ".send(color).on_blue.blink
            elsif cursor.selected != nil && cursor.selected.valid_moves.include?(pos)
              print " #{symbol} ".send(color).on_magenta
            else
              if i.even? && j.even?
                print " #{symbol} ".send(color).on_white
              elsif i.odd? && j.odd?
                print " #{symbol} ".send(color).on_white
              else
                print " #{symbol} ".send(color).on_black
              end
            end
          else
            print " #{symbol} ".send(color).on_red
          end
        end
        puts ""
      end
      cursor.get_input
    end
  end
end
