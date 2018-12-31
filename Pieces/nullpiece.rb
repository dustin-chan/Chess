require 'singleton'
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
