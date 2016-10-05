# Gosu file

require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize(width=800, height=400)
    @width     = width
    @height    = height
    super width, height, false                     # <-- width, height, fullscreen = false
    self.caption = "Conway's Game Of Life"

    # Color
    @background_color = Gosu::Color.new(0xffdedede)

    # Game itself
    @cols = width / 10
    @rows = height / 10
    @world = World.new(@cols, @rows)
    @game = Game.new(@world)
#    @game.world.randomly_populate

  end

  def update                                  # <-- updates game 60 times per second
                                              # <-- contains (or references) game logic
  end

  def draw                                    # <-- says to gosu gaming library how to flesh
                                              # <-- out bare game logic bones (colors, background, visual representations etc...)
    draw_quad(0, 0, @background_color,
              width, 0, @background_color,
              width, height, @background_color,
              0, height, @background_color)
  end

  def needs_cursor?; true; end

end


#GameOfLifeWindow.new.show
window = GameOfLifeWindow.new.show
window.show


