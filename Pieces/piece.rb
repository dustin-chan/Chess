class Piece
  attr_reader :board, :color
  attr_accessor :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def pos=(val)
    x, y = val
    @pos = val
  end

  def empty?
    false
  end

  def moves
    raise "moves method not implemented in piece"
  end

  def symbol
    raise "symbol not defined in piece subclass"
  end

  def to_s
    self.symbol
  end

  def valid_moves
    moves.select do |pos|

      board[pos].empty? || board[pos].color != self.color
    end
  end


  private
  # def move_into_check?(end_pos)
  #   if board[end_pos].is_a?(NullPiece)
  #     board.move_piece(pos, end_pos)
  #     self.pos = end_pos
  #   end
  # end
end
