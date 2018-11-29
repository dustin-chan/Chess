require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :board
  attr_accessor :pos, :selected

  def initialize(pos, board)
    @pos = pos
    @board = board
    @selected = nil
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                 # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                             # numeric keycode. chr returns a string of the
                             # character represented by the keycode.
                             # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                   # at most maxlen bytes from a
                                                   # data stream; it's nonblocking,
                                                   # meaning the method executes
                                                   # asynchronously; it raises an
                                                   # error if no data is available,
                                                   # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    case key
    when :left, :right, :up, :down
      update_pos(MOVES[key])
    when :return, :space
      if selected == nil
        toggle_selected
      else
        make_move
      end
    when :ctrl_c
      Process.exit(0)
    end
  end

  def toggle_selected
    piece = self.board[self.pos]
    self.selected = piece unless piece.empty?
  end

  def make_move
    if !board[self.pos].empty?
      if board[self.pos].color == selected.color
        toggle_selected
      elsif self.selected.valid_moves.include?(self.pos)
        move_piece
      end
    elsif self.selected.valid_moves.include?(self.pos)
      move_piece
    end
  end

  def move_piece
    old_pos = self.selected.pos.dup
    self.selected.pos = self.pos.dup
    self.board[pos] = self.selected
    self.board[old_pos] = self.board.sentinel
    self.selected = nil
  end

  def update_pos(diff)
    x = self.pos[0] + diff[0]
    y = self.pos[1] + diff[1]
    new_pos = [x,y]
    if board.valid_pos?(new_pos)
      self.pos[0] += diff[0]
      self.pos[1] += diff[1]
    else
      self.pos
    end
  end
end
