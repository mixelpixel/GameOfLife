# Gosu file

require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize
    super 640, 480, false
    self.caption = "Conway's Game Of Life"
  end

  def update
  end

  def draw
  end

end


#GameOfLifeWindow.new.show
window = GameOfLifeWindow.new.show
window.show


