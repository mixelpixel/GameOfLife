# spec file - I THINK THE is_a? calls need to be refactored.

require 'rspec'
require_relative 'game_of_life.rb'


describe 'Game of Life' do

  let!(:world) { World.new }

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

    it 'should detect a neighbor to the NORTH' do
      expect(subject.cell_grid[0][1]).to be_dead
      subject.cell_grid[0][1].alive = true
      expect(subject.cell_grid[0][1]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
    end

    it 'should detect a neighbor to the SOUTH' do
      expect(subject.cell_grid[2][1]).to be_dead
      subject.cell_grid[2][1].alive = true
      expect(subject.cell_grid[2][1]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
    end

    it 'should detect a neighbor to the WEST' do
      expect(subject.cell_grid[1][0]).to be_dead
      subject.cell_grid[1][0].alive = true
      expect(subject.cell_grid[1][0]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
    end

    it 'should detect a neighbor to the EAST' do
      expect(subject.cell_grid[1][2]).to be_dead
      subject.cell_grid[1][2].alive = true
      expect(subject.cell_grid[1][2]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
    end

    it 'should detect a neighbor to the NORTHWEST' do
      expect(subject.cell_grid[0][0]).to be_dead
      subject.cell_grid[0][0].alive = true
      expect(subject.cell_grid[0][0]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
    end

    it 'should detect a neighbor to the NORTHEAST' do
      expect(subject.cell_grid[0][2]).to be_dead
      subject.cell_grid[0][2].alive = true
      expect(subject.cell_grid[0][2]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
    end

    it 'should detect a neighbor to the SOUTHWEST' do
      expect(subject.cell_grid[2][0]).to be_dead
      subject.cell_grid[2][0].alive = true
      expect(subject.cell_grid[2][0]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
    end

    it 'should detect a neighbor to the SOUTHEAST' do
      expect(subject.cell_grid[2][2]).to be_dead
      subject.cell_grid[2][2].alive = true
      expect(subject.cell_grid[2][2]).to be_alive
      expect(subject.live_neighbors_around_cell(subject.cell_grid[1][1]).count) == 1
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
      it 'should kill a cell with one live neighbor' do
        game = Game.new(world, [[1, 0], [2, 0]])
        game.tick!
        expect(world.cell_grid[1][0]).to be_dead
        expect(world.cell_grid[2][0]).to be_dead
      end
    end
  end

end



