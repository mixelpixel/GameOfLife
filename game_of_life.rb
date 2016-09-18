# basic file

class World
  attr_accessor :rows, :cols, :cell_grid    # These methods are now accessible to rspec
  def initialize(rows=3, cols=3)            # default argument "=values"
    @rows      = rows
    @cols      = cols
    @cell_grid = Array.new(rows) do |row|
                   Array.new(cols) do |col|
                   end
                 end
  end                                       # These variablesi are now initialized

end


