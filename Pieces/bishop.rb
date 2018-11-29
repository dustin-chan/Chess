require_relative 'Modules/slideable'
require_relative 'piece.rb'
class Bishop < Piece
  include Slideable

  def symbol
    "♗"
  end

  protected
  def move_dirs
    diagonal_dirs
  end
end
