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
    @nought = Gosu::Image.new("media/nought.png")
    @cross = Gosu::Image.new("media/cross.png")
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

    if @board[0] == "O"
      @nought.draw(@buttonPos[0][0], @buttonPos[0][1], ZOrder::TOP)
    elsif @board[0] == "X"
      @cross.draw(@buttonPos[0][0], @buttonPos[0][1], ZOrder::TOP)
    end

    if @board[1] == "O"
      @nought.draw(@buttonPos[1][0], @buttonPos[1][1], ZOrder::TOP)
    elsif @board[1] == "X"
      @cross.draw(@buttonPos[1][0], @buttonPos[1][1], ZOrder::TOP)
    end

    if @board[2] == "O"
      @nought.draw(@buttonPos[2][0], @buttonPos[2][1], ZOrder::TOP)
    elsif @board[2] == "X"
      @cross.draw(@buttonPos[2][0], @buttonPos[2][1], ZOrder::TOP)
    end

    if @board[3] == "O"
      @nought.draw(@buttonPos[3][0], @buttonPos[3][1], ZOrder::TOP)
    elsif @board[3] == "X"
      @cross.draw(@buttonPos[3][0], @buttonPos[3][1], ZOrder::TOP)
    end

    if @board[4] == "O"
      @nought.draw(@buttonPos[4][0], @buttonPos[4][1], ZOrder::TOP)
    elsif @board[4] == "X"
      @cross.draw(@buttonPos[4][0], @buttonPos[4][1], ZOrder::TOP)
    end

    if @board[5] == "O"
      @nought.draw(@buttonPos[5][0], @buttonPos[5][1], ZOrder::TOP)
    elsif @board[5] == "X"
      @cross.draw(@buttonPos[5][0], @buttonPos[5][1], ZOrder::TOP)
    end

    if @board[6] == "O"
      @nought.draw(@buttonPos[6][0], @buttonPos[6][1], ZOrder::TOP)
    elsif @board[6] == "X"
      @cross.draw(@buttonPos[6][0], @buttonPos[6][1], ZOrder::TOP)
    end

    if @board[7] == "O"
      @nought.draw(@buttonPos[7][0], @buttonPos[7][1], ZOrder::TOP)
    elsif @board[7] == "X"
      @cross.draw(@buttonPos[7][0], @buttonPos[7][1], ZOrder::TOP)
    end

    if @board[8] == "O"
      @nought.draw(@buttonPos[8][0], @buttonPos[8][1], ZOrder::TOP)
    elsif @board[8] == "X"
      @cross.draw(@buttonPos[8][0], @buttonPos[8][1], ZOrder::TOP)
    end

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
      if ((mouse_x > @buttonPos[0][0] and mouse_x < @buttonPos[0][0] + @buttonWidth) and (mouse_y > @buttonPos[0][1] and mouse_y < @buttonPos[0][1] + @buttonWidth))
        if @board[0] != "O" and  @board[0] != "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 0)
        end
      end

      # Row 1 Col 2
      if ((mouse_x > @buttonPos[1][0] and mouse_x < @buttonPos[1][0] + @buttonWidth) and (mouse_y > @buttonPos[1][1] and mouse_y < @buttonPos[1][1] + @buttonWidth))
        if @board[1] != "O" and @board[1] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 1)
        end
      end

      # Row 1 Col 3
      if ((mouse_x > @buttonPos[2][0] and mouse_x < @buttonPos[2][0] + @buttonWidth) and (mouse_y > @buttonPos[2][1] and mouse_y < @buttonPos[2][1] + @buttonWidth))
        if @board[2] != "O" and @board[2] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 2)
        end
      end

      # Row 2 Col 1
      if ((mouse_x > @buttonPos[3][0] and mouse_x < @buttonPos[3][0] + @buttonWidth) and (mouse_y > @buttonPos[3][1] and mouse_y < @buttonPos[3][1] + @buttonWidth))
        if @board[3] != "O" and @board[3] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 3)
        end
      end

      # Row 2 Col 2
      if ((mouse_x > @buttonPos[4][0] and mouse_x < @buttonPos[4][0] + @buttonWidth) and (mouse_y > @buttonPos[4][1] and mouse_y < @buttonPos[4][1] + @buttonWidth))
        if @board[4] != "O" and @board[4] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 4)
        end
      end

      # Row 2 Col 3
      if ((mouse_x > @buttonPos[5][0] and mouse_x < @buttonPos[5][0] + @buttonWidth) and (mouse_y > @buttonPos[5][1] and mouse_y < @buttonPos[5][1] + @buttonWidth))
        if @board[5] != "O" and @board[5] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 5)
        end
      end

      # Row 3 Col 1
      if ((mouse_x > @buttonPos[6][0] and mouse_x < @buttonPos[6][0] + @buttonWidth) and (mouse_y > @buttonPos[6][1] and mouse_y < @buttonPos[6][1] + @buttonWidth))
        if @board[6] != "O" and @board[6] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 6)
        end
      end

      # Row 3 Col 2
      if ((mouse_x > @buttonPos[7][0] and mouse_x < @buttonPos[7][0] + @buttonWidth) and (mouse_y > @buttonPos[7][1] and mouse_y < @buttonPos[7][1] + @buttonWidth))
        if @board[7] != "O" and @board[7] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 7)
        end
      end

      # Row 3 Col 3
      if ((mouse_x > @buttonPos[8][0] and mouse_x < @buttonPos[8][0] + @buttonWidth) and (mouse_y > @buttonPos[8][1] and mouse_y < @buttonPos[8][1] + @buttonWidth)) 
        if @board[8] != "O" and @board[8] !=  "X"
          @playerTurn = CheckPlayerTurn(@playerTurn, 8)
        end
      end

    end
  end

  def CheckPlayerTurn(playerTurn, button)
    case playerTurn
    when "O"
      @board[button] = "O"
      playerTurn = "X"
    when "X"
      @board[button] = "X"
      playerTurn = "O"
    end
  end
end

GameWindow.new.show