# spec file

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of Life' do

  context 'world' do
    subject { World.new }

    it 'should create a new world object' do
      expect(subject.is_a?(World)).to be_truthy # not sure which is best
    end
    it 'should respond to proper methods' do
      expect(subject.respond_to?(:rows))
      expect(subject.respond_to?(:cols))
      expect(subject.respond_to?(:cell_grid))
    end
    it 'should create proper cell_grid upon initialization' do
      expect(subject.cell_grid.is_a?(Array)).to be_truthy #this or "be true"

      subject.cell_grid.each do |row|
        expect(row).to be_an(Array)
      end
    end

  end

end


