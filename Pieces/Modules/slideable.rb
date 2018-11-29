module Slideable
  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    #collects all different moves piece can do
    #references move_dirs of Piece subclass
    #returns an array of all possible moves for Piece subclass
    result = []
    move_dirs.each do |dir|
      result += grow_unblocked_moves_in_dir(dir[0],dir[1])
    end
    result
  end

  private
  def move_dirs
    raise "move_dirs method not implemented in piece"
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    result = []
    new_dx = self.pos[0] + dx
    new_dy = self.pos[1] + dy
    while self.board.valid_pos?([new_dx, new_dy])
      result << [new_dx,new_dy]
      break unless self.board[[new_dx, new_dy]].empty?
      new_dx += dx
      new_dy += dy
    end
    result
  end

  HORIZONTAL_DIRS = [[1,0],[-1,0],[0,1],[0,-1]].freeze

  DIAGONAL_DIRS = [[1,1],[-1,-1],[-1,1],[1,-1]].freeze
end
