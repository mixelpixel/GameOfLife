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

  end

end


