require_relative 'Modules/slideable'
require_relative 'piece.rb'
class Rook < Piece
  include Slideable

  def symbol
    "♖"
  end

  protected
  def move_dirs
    #horizontal
    horizontal_dirs
  end
end
