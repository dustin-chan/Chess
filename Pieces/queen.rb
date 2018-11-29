require_relative 'Modules/slideable'
require_relative 'piece.rb'
class Queen < Piece
  include Slideable

  def symbol
    "♕"
  end

  protected
  def move_dirs
    diagonal_dirs + horizontal_dirs
  end
end
