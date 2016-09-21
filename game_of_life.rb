# basic file

class World
  attr_accessor :rows, :cols, :cell_grid    # These methods are now accessible to rspec

  def initialize(rows=3, cols=3)            # default argument "=values"
    @rows      = rows
    @cols      = cols

   # [[Cell.new, Cell.new, Cell.new],
   #  [Cell.new, Cell.new, Cell.new]
   #  [Cell.new, Cell.new, Cell.new]]

    @cell_grid = Array.new(rows) do |row|
                   Array.new(cols) do |col|
                     Cell.new
                   end
                 end
  end                                       # These variables are now initialized

end

class Cell      # Minimum requirement for rspec
  attr_accessor :alive

  def initialize
    @alive == false
  end
end







