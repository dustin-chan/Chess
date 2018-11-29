module Stepable
  def moves
    new_moves = []
    move_diffs.each do |move|
      x = self.pos[0] + move[0]
      y = self.pos[1] + move[1]
      next if x < 0 || x > 7
      next if y < 0 || y > 7
      next if self.board[[x, y]].color == self.color
      new_moves << [x, y] if self.board.valid_pos?([x, y])
    end
    new_moves
  end

  private
  def move_diffs
    raise "move_diffs method not implemented in piece"
  end
end
