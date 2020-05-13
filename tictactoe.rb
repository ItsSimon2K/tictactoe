require "gosu"

module ZOrder
  BACKGROUND, BOTTOM, MIDDLE, TOP = *0..3
end

WIN_WIDTH = 640
WIN_HEIGHT = 400

class TicTacToe < Gosu::Window

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
    @board = ["", "", "",
              "", "", "",
              "", "", ""]
    
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

    for i in 0..8
      CheckAndDraw(i)
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
      for i in 0..8
        if mouse_over_button?(mouse_x, mouse_y, i, 0, 1)
          if @board[i] != "O" and  @board[i] != "X"
            @playerTurn = Handle_Turn(@playerTurn, i)
          end
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

  #Check the game board and draw either "X" or "O" on the screen 
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

  # Check the playerTurn then switch the turn to the other player
  def SwitchPlayerTurn(playerTurn)
    case playerTurn
    when "O"
      playerTurn = "X"
    when "X"
      playerTurn = "O"
    end
    return playerTurn
  end

  # Check the playerTurn then insert either "X" or "O" into the game board
  def PlaceSign(playerTurn, button)
    case playerTurn
    when "O"
      @board[button] = "O"
    when "X"
      @board[button] = "X"
    end
  end
end

TicTacToe.new.show