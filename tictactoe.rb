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
    # Image of "O"
    @nought = Gosu::Image.new("media/nought.png")
    # Image of "X"
    @cross = Gosu::Image.new("media/cross.png")
    # Game condition
    @isGameEnd = false
    # Game board
    @board = ["-", "-", "-",
              "-", "-", "-",
              "-", "-", "-"]
    
    # Top right Coords of each button
    @buttonPos = [[200, 95],[280, 95],[360, 95],
                  [200, 175],[280, 175],[360, 175],
                  [200, 255],[280, 255],[360, 255]]
    # Button width
    @buttonWidth = 80
  end

  def draw
    # Game board
    draw_rect(200, 95, 240, 240, Gosu::Color::RED, ZOrder::BOTTOM)
    draw_line(200, 176, Gosu::Color::BLACK, 440, 176, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    draw_line(200, 256, Gosu::Color::BLACK, 440, 256, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    draw_line(281, 95, Gosu::Color::BLACK, 281, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
    draw_line(361, 95, Gosu::Color::BLACK, 361, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)

    # check board[0] then draw in row 1 col 1
    CheckAndDraw(0)

    # check board[1] then draw in row 1 col 2
    CheckAndDraw(1)

    # check board[2] then draw in row 1 col 3
    CheckAndDraw(2)

    # check board[3] then draw in row 2 col 1
    CheckAndDraw(3)

    # check board[4] then draw in row 2 col 2
    CheckAndDraw(4)

    # check board[5] then draw in row 2 col 3
    CheckAndDraw(5)

    # check board[6] then draw in row 3 col 1
    CheckAndDraw(6)

    # check board[7] then draw in row 3 col 2
    CheckAndDraw(7)

    # check board[8] then draw in row 3 col 3
    CheckAndDraw(8)
  end

  def update

  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::MsLeft
      # Row 1 Col 1
      if mouse_over_button?(mouse_x, mouse_y, 0, 0, 1)
        if @board[0] != "O" and  @board[0] != "X"
          @playerTurn = Handle_Turn(@playerTurn, 0)
        end
      end

      # Row 1 Col 2
      if mouse_over_button?(mouse_x, mouse_y, 1, 0, 1)
        if @board[1] != "O" and @board[1] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 1)
        end
      end

      # Row 1 Col 3
      if mouse_over_button?(mouse_x, mouse_y, 2, 0, 1)
        if @board[2] != "O" and @board[2] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 2)
        end
      end

      # Row 2 Col 1
      if mouse_over_button?(mouse_x, mouse_y, 3, 0, 1)
        if @board[3] != "O" and @board[3] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 3)
        end
      end

      # Row 2 Col 2
      if mouse_over_button?(mouse_x, mouse_y, 4, 0, 1)
        if @board[4] != "O" and @board[4] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 4)
        end
      end

      # Row 2 Col 3
      if mouse_over_button?(mouse_x, mouse_y, 5, 0, 1)
        if @board[5] != "O" and @board[5] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 5)
        end
      end

      # Row 3 Col 1
      if mouse_over_button?(mouse_x, mouse_y, 6, 0, 1)
        if @board[6] != "O" and @board[6] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 6)
        end
      end

      # Row 3 Col 2
      if mouse_over_button?(mouse_x, mouse_y, 7, 0, 1)
        if @board[7] != "O" and @board[7] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 7)
        end
      end

      # Row 3 Col 3
      if mouse_over_button?(mouse_x, mouse_y, 8, 0, 1)
        if @board[8] != "O" and @board[8] !=  "X"
          @playerTurn = Handle_Turn(@playerTurn, 8)
        end
      end

    end
  end

  def mouse_over_button?(mouse_x, mouse_y, button, button_x, button_y)
    if ((mouse_x > @buttonPos[button][button_x] and mouse_x < @buttonPos[button][button_x] + @buttonWidth) and (mouse_y > @buttonPos[button][button_y] and mouse_y < @buttonPos[button][button_y] + @buttonWidth)) 
      true
    else
      false
    end
  end

  def CheckAndDraw(button)
    case @board[button]
    when "O"
      @nought.draw(@buttonPos[button][0], @buttonPos[button][1], ZOrder::TOP)
    when "X"
      @cross.draw(@buttonPos[button][0], @buttonPos[button][1], ZOrder::TOP)
    end
  end

  def Handle_Turn(playerTurn, button)
    PlaceSign(playerTurn,button)
    SwitchPlayerTurn(playerTurn)
  end

  def SwitchPlayerTurn(playerTurn)
    case playerTurn
    when "O"
      playerTurn = "X"
    when "X"
      playerTurn = "O"
    end
    return playerTurn
  end

  def PlaceSign(playerTurn, button)
    case playerTurn
    when "O"
      @board[button] = "O"
    when "X"
      @board[button] = "X"
    end
  end
end

GameWindow.new.show