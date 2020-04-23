require "gosu"

module ZOrder
  BACKGROUND, BOTTOM, MIDDLE, TOP = *0..3
end

WIN_WIDTH = 640
WIN_HEIGHT = 400

class GameWindow < Gosu::Window

  def initialize
    super(WIN_WIDTH, WIN_HEIGHT, false)

    # Player's Turn
    @playerTurn = "O" 

    @isGameEnd = false

    @board = ["-", "-", "-",
              "-", "-", "-",
              "-", "-", "-"]
    
    # Top right Coords of each button
    @buttonPos = [[200, 95],[280, 95],[360, 95],
                  [200, 175],[280, 175],[360, 175],
                  [200, 255],[280, 255],[360, 255]]
    
    @buttonWidth = 80
  end

  def draw
    draw_rect(200, 95, 240, 240, Gosu::Color::RED, ZOrder::BOTTOM)

    draw_line(200, 176, Gosu::Color::BLACK, 440, 176, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    draw_line(200, 256, Gosu::Color::BLACK, 440, 256, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    draw_line(281, 95, Gosu::Color::BLACK, 281, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    draw_line(361, 95, Gosu::Color::BLACK, 361, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::MsLeft

    end
  end
end

GameWindow.new.show