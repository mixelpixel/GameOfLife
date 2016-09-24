# spec file - I THINK THE is_a? calls need to be refactored.

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of Life' do

  context 'world' do
    subject { World.new }

    let!(:world) { World.new }

    it 'should create a new world object' do
      expect(subject.is_a?(World)).to be_truthy # not sure which is best
    end
    it 'should respond to proper methods' do
      expect(subject).to respond_to(:rows)
      expect(subject).to respond_to(:cols)
      expect(subject).to respond_to(:cell_grid)
    end

    it 'should create proper cell_grid upon initialization' do
      expect(subject.cell_grid.is_a?(Array)).to be_truthy #this or "be true"
    # THIS WHOLE SPEC CAN BE REFACTORED
      subject.cell_grid.each do |row|
        expect(row).to be_an(Array)
        row.each do |col|
          expect(col).to be_a(Cell)     # <-- be_a or be_an, Neat-O
        end
      end
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
    end

    it 'should initialize properly' do
      expect(subject.alive).to be_falsey
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

    it 'should plant seeds properly' do
      game = Game.new(world, [[1, 2], [0, 2]])
    end

    end
  end

  context 'Rules' do

  let!(:game) { Game.new }

    context 'Rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population.' do
      it 'should kill a cell with one live neighbor' do
      end
    end

  end

end







