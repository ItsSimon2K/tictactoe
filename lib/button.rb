# Button Class
class Button

  def initialize(window, button_x, button_y, button_width, button_height, text_content)
    @window = window
    @button_x = button_x
    @button_y = button_y
    @button_width = button_width
    @button_height = button_height
    @button_color = Gosu::Color::RED
    @button_hover = Gosu::Color::WHITE
    @button_zorder = ZOrder::BOTTOM
    @text = Gosu::Font.new(25)
    @text_content = text_content
    @text_color = Gosu::Color::WHITE
    @text_hover = Gosu::Color::RED
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
                    mouse_over_button? ? @text_hover : @text_color,
                    mode=:default)
  end

  def update
    if mouse_over_button?
      @button_color = Gosu::Color::WHITE
      @text_color = Gosu::Color::RED
    else
      @button_color = Gosu::Color::RED
      @text_color = Gosu::Color::WHITE
    end
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