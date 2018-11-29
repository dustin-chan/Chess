# require_relative 'piece.rb'
require 'singleton'
# require_relative 'board.rb'
class NullPiece < Piece
  include Singleton

  def initialize
    @color = :red
  end

  def empty?
    true
  end

  def symbol
    " "
  end
end
