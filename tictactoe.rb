require "gosu"

module ZOrder
  BACKGROUND, BOTTOM, MIDDLE, TOP = *0..3
end

WIN_WIDTH = 640
WIN_HEIGHT = 400

class GameWindow < Gosu::Window

  def initialize
    super(WIN_WIDTH, WIN_HEIGHT, false)
  end

  def draw

  end

  def needs_cursor?
    true
  end

  def button_down(id)

  end

end

GameWindow.new.show