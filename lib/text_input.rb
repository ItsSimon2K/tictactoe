# Text input class
# Reference: https://github.com/gosu/gosu-examples/blob/master/examples/text_input.rb
class TextInput < Gosu::TextInput
  INACTIVE_COLOR    = 0xcc_666666
  ACTIVE_COLOR      = 0xcc_ff6666
  CARET_COLOR       = 0xff_ffffff
  PLACEHOLDER_COLOR = 0x88_ffffff
  TEXT_COLOR        = 0xff_ffffff

  attr_reader :x, :y

  def initialize(window, font, x, y, zorder, width, height, placeholder)
    super()

    @window = window
    @font = font
    @x = x
    @y = y
    @zorder = zorder
    @width = width
    @height = height
    @placeholder = placeholder
  end

  def button_down(id)
    if id == Gosu::MS_LEFT && mouse_over_button?
      @window.text_input = self
      self.caret_pos = self.selection_start = text.length
    end
  end

  def draw
    # Change background color if in focus
    if @window.text_input == self
      bg_color = ACTIVE_COLOR
    else
      bg_color = INACTIVE_COLOR
    end

    Gosu.draw_rect(@x, @y, @width, @height, bg_color, @zorder)

    # Draw caret if focus
    if @window.text_input == self
      pos_x = @x + @font.text_width(text[0...caret_pos]) + 10

      Gosu.draw_line(
        pos_x,
        @y,
        CARET_COLOR,
        pos_x,
        @y + @height,
        CARET_COLOR,
        @zorder
      )
    end

    @font.draw_text_rel(
      text.empty? ? @placeholder : text,
      @x + 10,
      @y + @height / 2,
      @zorder,
      0,
      0.5,
      1,
      1,
      text.empty? ? PLACEHOLDER_COLOR : TEXT_COLOR
    )
  end

  def mouse_over_button?
    if ((@window.mouse_x > @x && @window.mouse_x < @x + @width) && 
      (@window.mouse_y > @y && @window.mouse_y < @y + @height)) 
      true
    else
      false
    end
  end
end