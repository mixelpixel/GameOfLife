# spec file

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of Life' do

  context 'world' do
    subject { World.new }

    it 'should create a new world object' do
      expect(subject.is_a?(World)).to be true
    end
    it 'should respond to proper methods' do
      expect(subject.respond_to?(:rows))
      expect(subject.respond_to?(:cols))
      expect(subject.respond_to?(:cell_grid))
    end
    it 'should create proper cell_grid upon initialization' do
      expect(subject.cell_grid.is_a?(Array)).to be true

      expect{ subject.cell_grid.all? { |k| k.is_a?(Array) } }.to be true
    end

  end

end


