# Board Class
class Board
  attr_accessor :board, :button_pos

  def initialize

    @board = ["", "", "",
              "", "", "",
              "", "", ""]

    # Top right Coords of each button on the board
    @button_pos = [[200, 95],[280, 95],[360, 95],
                  [200, 175],[280, 175],[360, 175],
                  [200, 255],[280, 255],[360, 255]]

    # Button's width & height on the board
    @button_width = 80
    @button_height = 80

    # Image of "O"
    @nought = Gosu::Image.new("media/nought.png")
    # Image of "X"
    @cross = Gosu::Image.new("media/cross.png")
  end

  def draw
    Gosu.draw_rect(200, 95, 240, 240, 0xFF1D5DBA, ZOrder::BOTTOM)

    Gosu.draw_line(200, 175, Gosu::Color::BLACK, 
                   440, 175, Gosu::Color::BLACK, 
                   ZOrder::MIDDLE, mode=:default)

    Gosu.draw_line(200, 255, Gosu::Color::BLACK, 
                   440, 255, Gosu::Color::BLACK, 
                   ZOrder::MIDDLE, mode=:default)

    Gosu.draw_line(280, 95, Gosu::Color::BLACK, 
                   280, 335, Gosu::Color::BLACK, 
                   ZOrder::MIDDLE, mode=:default)

    Gosu.draw_line(360, 95, Gosu::Color::BLACK, 
                   360, 335, Gosu::Color::BLACK, 
                   ZOrder::MIDDLE, mode=:default)

    for i in 0..8
      check_and_draw(i)
    end
  end

  def mouse_over_button?(mouse_x, mouse_y, button_x, button_y)
    if ((mouse_x > button_x && mouse_x < button_x + @button_width) && 
      (mouse_y > button_y && mouse_y < button_y + @button_height)) 
      true
    else
      false
    end
  end

  # Check the game board and draw either "X" or "O" on the screen 
  def check_and_draw(button)
    case @board[button]
    when "O"
      @nought.draw(@button_pos[button][0], 
                   @button_pos[button][1], 
                   ZOrder::TOP)
    when "X"
      @cross.draw(@button_pos[button][0], 
                  @button_pos[button][1], 
                  ZOrder::TOP)
    end
  end
end