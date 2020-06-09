# Button Class
class Button

  def initialize(window, button_x, button_y, button_width, button_height, text_content)
    @window = window
    @button_x = button_x
    @button_y = button_y
    @button_width = button_width
    @button_height = button_height
    @button_color = 0xFF1D4DB5
    @button_hover = 0xFF1D5DBA
    @button_zorder = ZOrder::BOTTOM
    @text = Gosu::Font.new(25)
    @text_content = text_content
    @text_color = Gosu::Color::WHITE
    @text_zorder = ZOrder::MIDDLE
  end

  def draw
    Gosu.draw_rect(@button_x, 
                   @button_y, 
                   @button_width, 
                   @button_height, 
                   mouse_over_button? ? @button_hover : @button_color,
                   @button_zorder)

    @text.draw_text(@text_content, 
                    @button_x + (@button_width / 8), 
                    @button_y + (@button_height / 4), 
                    @text_zorder, 
                    1, 
                    1, 
                    @text_color,
                    mode=:default)
  end

  def button_down(id)
    if id == Gosu::MsLeft && mouse_over_button?
      true
    else
      false
    end
  end

  def mouse_over_button?
    if ((@window.mouse_x > @button_x && @window.mouse_x < @button_x + @button_width) &&
      (@window.mouse_y > @button_y && @window.mouse_y < @button_y + @button_height)) 
      true
    else
      false
    end
  end
end