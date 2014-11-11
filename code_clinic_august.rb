class Board

  def initialize
    @row = (1..8).to_a
    @column = (1..8).to_a
    @board = @column.product(@row).to_a
  end

  def display
    @board.each do |y,x|
      if x == 8
        print " *\n"
      else
        print " *"
      end
    end
    print "\n"
  end

 def find_coord(row, column)
   @board.each do |y, x|
      if x == 8
        print " *\n"
      elsif x == row && y == column
        print " $"
      else
        print " *"
      end
    end
    print "\n"
  end


end



board = Board.new
board.display
board.find_coord(3, 1)