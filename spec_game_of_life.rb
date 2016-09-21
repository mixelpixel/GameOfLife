# spec file - I THINK THE is_a? calls need to be refactored.

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of Life' do

  context 'world' do
    subject { World.new }

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

  context 'cell' do
    subject { Cell.new }

    it 'should create a new cell object' do
      expect(subject.is_a?(Cell)).to be_truthy
    end

    it 'should respond to proper methods' do
      expect(subject).to respond_to(:alive)
    end

    it'should initialize properly' do
      expect(subject.alive).to be_falsey
    end

  end

end






























