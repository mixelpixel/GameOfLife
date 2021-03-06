# basic game of life game file

class Game
  attr_accessor :world, :seeds

  def initialize(world=World.new, seeds=[])
    @world     = world
    @seeds     = seeds

    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end

  def tick!
    next_round_live_cells = []
    next_round_dead_cells = []

    world.cells.each do |cell|
      # Rule 1
      if cell.alive && world.live_neighbors_around_cell(cell).count < 2
        next_round_dead_cells << cell
      end
      # Rule 2
      if cell.alive && ([2, 3].include? world.live_neighbors_around_cell(cell).count)
        next_round_live_cells << cell
      end
      # Rule 3
      if cell.alive? && world.live_neighbors_around_cell(cell).count > 3
        next_round_dead_cells << cell
      end
      # Rule 4
      if cell.dead? && world.live_neighbors_around_cell(cell).count == 3
        next_round_live_cells << cell
      end
    end

    next_round_live_cells.each do |cell|
      cell.revive!
    end
    next_round_dead_cells.each do |cell|
      cell.die!
    end

  end
end


class World
  attr_accessor :rows, :cols, :cell_grid, :cells

  def initialize(rows=3, cols=3)     # Why the (rows, cols) here then (col, row) ???
    @rows      = rows
    @cols      = cols
    @cells     = []

   # [[Cell.new, Cell.new, Cell.new], # [[[0][0], [1][0], [2][0]],
   #  [Cell.new, Cell.new, Cell.new]  #  [[0][1], [1][1], [2][1]],
   #  [Cell.new, Cell.new, Cell.new]] #  [[0][2], [1][2], [2][2]]]    (col, row) ???
    @cell_grid = Array.new(rows) do |row|
                   Array.new(cols) do |col|
                     cell = Cell.new(col, row)
                     cells << cell
                     cell     # why are we returning cell and not cells?
                   end
                 end
  end

  def live_neighbors_around_cell(cell)
    live_neighbors = []

    # NORTH
    if cell.y > 0  # NOTE: there are no neighbors North of the TOP row (cell.y < 0) 
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbors << candidate if candidate.alive
      # the candidate is added to the live_neighbors list
    end
 
    # SOUTH
    if cell.y < (rows - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x]
      live_neighbors << candidate if candidate.alive
    end
 
    # WEST
    if cell.x > 0 
      candidate = self.cell_grid[cell.y][cell.x - 1]
      live_neighbors << candidate if candidate.alive
    end
 
    # EAST
    if cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y][cell.x + 1]
      live_neighbors << candidate if candidate.alive
    end
 
    # NORTHWEST
    if cell.y > 0 && cell.x > 0 
      candidate = self.cell_grid[cell.y - 1][cell.x - 1]
      live_neighbors << candidate if candidate.alive
    end

    # NORTHEAST
    if cell.y > 0 && cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y - 1][cell.x + 1]
      live_neighbors << candidate if candidate.alive
    end

    # SOUTHWEST
    if cell.y < (rows - 1) && cell.x > 0 
      candidate = self.cell_grid[cell.y + 1][cell.x - 1]
      live_neighbors << candidate if candidate.alive
    end

    # SOUTHEAST
    if cell.y < (rows - 1)  && cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x + 1]
      live_neighbors << candidate if candidate.alive
    end

    live_neighbors # live neighbors is returned

  end

  def live_cells
    cells.select { |cell| cell.alive }
  end

  def randomly_populate
    cells.each do |cell|
      cell.alive = [true, false].sample
    end
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

  def die!
    @alive = false
  end

  def revive!
    @alive = true
  end

end







