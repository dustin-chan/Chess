require_relative 'Pieces/pieces.rb'
require_relative 'Pieces/nullpiece'
require_relative 'display.rb'
require "byebug"
require_relative 'cursor'

class Board
  attr_accessor :rows
  attr_reader :sentinel
  def initialize
    @sentinel = NullPiece.instance()
    @rows = setup
    @bking = nil
  end

  def setup
    self.rows = Array.new(8){Array.new(8)}
    self.rows.each_with_index do |row,i|
      row.each_with_index do |col,j|
        case i
        when 0
          self[[i,j]] = PIECES[j].new(:yellow,self,[i,j])
        when 1
          self[[i, j]] = Pawn.new(:yellow,self,[i,j])
        when 2..5
          self[[i, j]] = self.sentinel
        when 6
          self[[i, j]] = Pawn.new(:cyan,self,[i,j])
        when 7
          self[[i,j]] = PIECES[j].new(:cyan,self,[i,j])
        end
      end
    end
  end

  def move_piece(start_pos,end_pos)
    raise "There is no piece there" if self[start_pos].empty?
    raise "That position is occupied" unless self[end_pos].empty?
    self[start_pos].pos = end_pos
    self[start_pos], self[end_pos] = self.sentinel, self[start_pos]
  end

  def in_check?(color)
  end

  def checkmate?(color)

  end

  def valid_pos?(pos)
    return false if pos.any? {|num| num < 0 || num > 7}
    true
  end

  def [](pos)
    x,y = pos
    self.rows[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    self.rows[x][y] = piece
  end

  private
  PIECES = [Rook,Knight,Bishop,Queen,King,Bishop,Knight,Rook]
end

board = Board.new
display = Display.new(board)
display.render
