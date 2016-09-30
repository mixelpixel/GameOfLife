# basic file

class Game
  attr_accessor :world, :seeds

  def initialize(world=World.new, seeds=[])
    @world     = world
    @seeds     = seeds

    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end

end


class World
  attr_accessor :rows, :cols, :cell_grid

  def initialize(rows=3, cols=3)
    @rows      = rows
    @cols      = cols

   # [[Cell.new, Cell.new, Cell.new], # [[[0][0], [0][1], [0][2]],
   #  [Cell.new, Cell.new, Cell.new]  #  [[1][0], [1][1], [1][2]],
   #  [Cell.new, Cell.new, Cell.new]] #  [[2][0], [2][1], [2][2]]]
    @cell_grid = Array.new(rows) do |row|
                   Array.new(cols) do |col|
                     Cell.new(col, row)
                   end
                 end
  end

  def live_neighbors_around_cell(cell)
    live_neighbors = []

    # it detects a neighbor to the North
    if cell.y > 0                                    # No neighbors to the North of the TOP row (cell.y < 0)
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbors << candidate if candidate.alive
    end

    live_neighbors
  end

end


class Cell
  attr_accessor :alive, :x, :y

  def initialize(x=0, y=0)
    @alive = false
    @x = x
    @y = y
  end

  def alive?; alive; end

  def dead?; not alive; end

end







