require_relative 'piece.rb'
class Pawn < Piece
  def symbol
    "♙"
  end

  def move_dirs
    [[forward_dir, 0]] #select only forward moves
  end

  def moves
    valid_moves = forward_steps.select do |move|
      self.board[[move[0], move[1]]].empty?
    end

    valid_attacks = side_attacks.select do |move|
      if self.color == :cyan
        self.board[[move[0], move[1]]].color == :yellow
      else
        self.board[[move[0], move[1]]].color == :cyan
      end
    end

    valid_moves + valid_attacks
  end

  private
  def at_start_row?
    return true if self.pos[0] == 1 && self.color == :yellow
    return true if self.pos[0] == 6 && self.color == :cyan
    false
  end

  def forward_dir
    #returns 1 or -1
    if self.color == :cyan
      return -1
    else
      return 1
    end
  end

  def forward_steps
    x = self.pos[0]
    y = self.pos[1]
    next_tile = self.board[[x + forward_dir, y]]
    steps = [[x + forward_dir, y]]
    if at_start_row?
      steps << [x + forward_dir * 2, y] if next_tile.empty?
    end
    steps
  end

  def side_attacks
    x = self.pos[0]
    y = self.pos[1]
    [[x + forward_dir, y + forward_dir], [x + forward_dir, y - forward_dir]]
  end
end
