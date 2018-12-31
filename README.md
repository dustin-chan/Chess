# Chess
A ruby terminal Chess game.

### Controls 

* Arrow keys to move
* Enter to select spaces

## Technologies 

* Ruby

## Features 

### Rendering

If a piece is selected the board will render the valid moves for that piece in a different color than the rest of the board.

```javascript
  def render
    until false
      system("clear")
      board.rows.each_with_index do |row,i|
        row.each_with_index do |col,j|
          pos = [i,j]
          symbol = board[pos].symbol
          color = board[pos].color
          unless pos == cursor.pos
            if cursor.selected != nil && cursor.selected.pos == pos
              print print " #{symbol} ".send(color).on_blue.blink
            elsif cursor.selected != nil && cursor.selected.valid_moves.include?(pos)
              print " #{symbol} ".send(color).on_magenta
            else
              if i.even? && j.even?
                print " #{symbol} ".send(color).on_white
              elsif i.odd? && j.odd?
                print " #{symbol} ".send(color).on_white
              else
                print " #{symbol} ".send(color).on_black
              end
            end
          else
            print " #{symbol} ".send(color).on_red
          end
        end
        puts ""
      end
      cursor.get_input
    end
  end
```

### Movement Modules

The use of modules significantly reduced the amount of code necessary.

```javascript 
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
```
