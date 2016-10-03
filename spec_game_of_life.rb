# spec file - I THINK THE is_a? calls need to be refactored.

require 'rspec'
require_relative 'game_of_life.rb'


describe 'Game of Life' do

  let!(:world) { World.new }
  let!(:cell) { Cell.new(1, 1) }

  context 'World' do
    subject { World.new }

    it 'should create a new world object' do
      expect(subject.is_a?(World)).to be_truthy # not sure which is best
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
      expect(subject).to respond_to(:live_neighbors_around_cell)
      expect(subject).to respond_to(:cells)
    end

    it 'should create proper cell_grid upon initialization' do
      expect(subject.cell_grid.is_a?(Array)).to be_truthy #this or "be true"

      subject.cell_grid.each do |row|   # THIS WHOLE SPEC CAN BE REFACTORED
        expect(row).to be_an(Array)
        row.each do |col|
          expect(col).to be_a(Cell)     # <-- be_a or be_an, Neat-O
        end
      end
    end

    it 'should add all cells to cells array' do
      expect(subject.cells.count == 9).to be_truthy        # 9 == the 3x3 default grid
    end

    it 'should detect a neighbor to the NORTH' do
      subject.cell_grid[cell.y - 1][cell.x].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end

    it 'should detect a neighbor to the SOUTH' do
      subject.cell_grid[cell.y + 1][cell.x].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end

    it 'should detect a neighbor to the WEST' do
      subject.cell_grid[cell.y][cell.x - 1].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end

    it 'should detect a neighbor to the EAST' do
      subject.cell_grid[cell.y][cell.x + 1].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end

    it 'should detect a neighbor to the NORTHWEST' do
      subject.cell_grid[cell.y - 1][cell.x - 1].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end

    it 'should detect a neighbor to the NORTHEAST' do
      subject.cell_grid[cell.y - 1][cell.x + 1].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end

    it 'should detect a neighbor to the SOUTHWEST' do
      subject.cell_grid[cell.y + 1][cell.x - 1].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end

    it 'should detect a neighbor to the SOUTHEAST' do
      subject.cell_grid[cell.y + 1][cell.x + 1].alive = true
      expect(subject.live_neighbors_around_cell(cell).count == 1).to be_truthy
    end
  end


  context 'Cell' do
    subject { Cell.new }

    it 'should create a new cell object' do
      expect(subject.is_a?(Cell)).to be_truthy
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:alive)
      expect(subject).to respond_to(:x)
      expect(subject).to respond_to(:y)
      expect(subject).to respond_to(:alive?)
      expect(subject).to respond_to(:die!)
      expect(subject).to respond_to(:revive!)
   end

    it 'should initialize properly' do
      expect(subject.alive).to be == false
      expect(subject.x).to be == 0
      expect(subject.y).to be == 0
    end
  end


  context 'Game' do
    subject { Game.new }

    it 'should create a new Game object' do
      expect(subject.is_a?(Game)).to be_truthy
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:world)
      expect(subject).to respond_to(:seeds)
    end

    it 'should initialize properly' do
      expect(subject.world).to be_a(World)
      expect(subject.seeds).to be_a(Array)
    end

    it 'should plant seeds properly' do
      game = Game.new(world, [[1, 2], [0, 2]])
      expect(world.cell_grid[1][2]).to be_alive
      expect(world.cell_grid[0][2]).to be_alive
    end
  end


  context 'Rules' do

  let!(:game) { Game.new }

    context 'Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do

      it 'should kill a live cell with NO live neighbors' do
        game.world.cell_grid[1][1].alive = true
        expect(game.world.cell_grid[1][1]).to be_alive
        game.tick!
        expect(game.world.cell_grid[1][1]).to be_dead
      end

      it 'should kill a cell with ONE live neighbor' do
        game = Game.new(world, [[1, 0], [2, 0]])
        game.tick!
        expect(world.cell_grid[1][0]).to be_dead
        expect(world.cell_grid[2][0]).to be_dead
      end

      it 'DOES NOT kill live cells with TWO live neighbors' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
        game.tick!
        expect(world.cell_grid[1][1]).to be_alive
      end

    end

    context 'Rule 2: Any live cell with two or three live neighbours lives on to the next generation.' do
      it 'should keep alive a cell with TWO neighbors' do
        game = Game.new(world, [[0, 0], [0, 1], [0, 2]])
        expect(world.live_neighbors_around_cell(world.cell_grid[0][1]).count == 2).to be_truthy
        game.tick!
        expect(world.cell_grid[0][0]).to be_dead 
        expect(world.cell_grid[0][1]).to be_alive 
        expect(world.cell_grid[0][2]).to be_dead 
      end

      it 'should keep alive a cell with THREE neighbors' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2]])
        expect(world.live_neighbors_around_cell(world.cell_grid[1][1]).count == 3).to be_truthy
        game.tick!
        expect(world.cell_grid[0][1]).to be_dead
        expect(world.cell_grid[1][1]).to be_alive
        expect(world.cell_grid[2][1]).to be_alive
        expect(world.cell_grid[2][2]).to be_alive
      end
    end
 
    context 'Rule 3: Any live cell with more than three live neighbours dies, as if by over-population.' do
      it 'should kill a cell with four or more neighbors' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1], [2, 2], [1, 2]])
        expect(world.live_neighbors_around_cell(world.cell_grid[1][1]).count == 4).to be_truthy
        game.tick!
        expect(world.cell_grid[0][1]).to be_alive
        expect(world.cell_grid[1][1]).to be_dead
        expect(world.cell_grid[2][1]).to be_alive
        expect(world.cell_grid[2][2]).to be_alive
        expect(world.cell_grid[1][2]).to be_dead
      end
    end

    context 'Rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.' do
      it 'should make come to life a dead cell with ONLY three live neighbors' do
        game = Game.new(world, [[0, 1], [1, 1], [2, 1]])
        expect(world.live_neighbors_around_cell(world.cell_grid[1][0]).count == 3).to be_truthy
        game.tick!
        expect(world.cell_grid[1][0]).to be_truthy
        expect(world.cell_grid[1][2]).to be_truthy
      end
    end
 
  end

end



