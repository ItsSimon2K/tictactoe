require "gosu"

module ZOrder
  BACKGROUND, BOTTOM, MIDDLE, TOP = *0..3
end

WIN_WIDTH = 640
WIN_HEIGHT = 400

class TicTacToe < Gosu::Window

  def initialize
    super(WIN_WIDTH, WIN_HEIGHT, false)
    @text = Gosu::Font.new(50)
    # Player's Turn
    @playerTurn = "O"
    # Winner
    @winner = ""
    # Image of "O"
    @nought = Gosu::Image.new("media/nought.png")
    # Image of "X"
    @cross = Gosu::Image.new("media/cross.png")
    # Game condition
    @game = true
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
    if (@game)
      # Display player's turn
      @text.draw_text((@playerTurn + "\'s Turn"), 230, 50, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)

      # Game board
      draw_rect(200, 95, 240, 240, Gosu::Color::RED, ZOrder::BOTTOM)
      draw_line(200, 176, Gosu::Color::BLACK, 440, 176, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
      draw_line(200, 256, Gosu::Color::BLACK, 440, 256, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
      draw_line(281, 95, Gosu::Color::BLACK, 281, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
      draw_line(361, 95, Gosu::Color::BLACK, 361, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)

      # Check the board and draw sign on the screen
      for i in 0..8
        CheckAndDraw(i)
      end
    end

    if (!@game)
      if @winner == "X" or @winner == "O"
        # Display winner when the game ends and theres no tie
        @text.draw((@winner + " Won!"), 230, 50, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)
      elsif @winner == ""
        @text.draw(("It's a tie!"), 230, 50, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)
      end

      # Reset game button


      # Exit game button
    end

  end

  def update
    if (@game)
      CheckForWinner()
    end
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::MsLeft

      if (@game)
        for i in 0..8
          if mouse_over_button?(mouse_x, mouse_y, @buttonPos[i][0], @buttonPos[i][1], @buttonWidth)
            if @board[i] != "O" and  @board[i] != "X"
              @playerTurn = Handle_Turn(@playerTurn, i)
            end
          end
        end
      end

      if (!@game)
        # Reset game button


        # Exit game button
      end
      
    end
  end

  def mouse_over_button?(mouse_x, mouse_y, button_x, button_y, button_width)
    if ((mouse_x > button_x and mouse_x < button_x + button_width) and (mouse_y > button_y and mouse_y < button_y + button_width)) 
      true
    else
      false
    end
  end

  # Check the game board and draw either "X" or "O" on the screen 
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

  def CheckForWinner
    diagonalwinner = CheckDiagonal(@board)
    verticalwinner = CheckVertical(@board)
    horizontalwinner = CheckHorizontal(@board)
    if diagonalwinner
      @winner = diagonalwinner
    elsif verticalwinner
      @winner = verticalwinner
    elsif horizontalwinner
      @winner = horizontalwinner
    else
      if !(@board.include? "")
        @winner = ""
        @game = false
      end
    end
  end

  # Check both diagonal
  def CheckDiagonal(board)
    diagonal1 = board[0] == board[4] && board[0] == board[8] && board[0] != ""
    diagonal2 = board[2] == board[4] && board[2] == board[6] && board[2] != ""

    if diagonal1 || diagonal2
      @game = false
    end

    if diagonal1
      return board[0]
    elsif diagonal2
      return board[2]
    end
  end

  # Check all the columns
  def CheckVertical(board)
    col1 = board[0] == board[3] && board[0] == board[6] && board[0] != ""
    col2 = board[1] == board[4] && board[1] == board[7] && board[1] != ""
    col3 = board[2] == board[5] && board[2] == board[8] && board[2] != ""

    if col1 || col2 || col3
      @game = false
    end

    if col1
      return board[0]
    elsif col2
      return board[1]
    elsif col3
      return board[2]
    end
  end

  # Check all the rows
  def CheckHorizontal(board)
    row1 = board[0] == board[1] && board[0] == board[2] && board[0] != ""
    row2 = board[3] == board[4] && board[3] == board[5] && board[3] != ""
    row3 = board[6] == board[7] && board[6] == board[8] && board[6] != ""

    if row1 || row2 || row3
      @game = false
    end

    if row1
      return board[0]
    elsif row2
      return board[3]
    elsif row3
      return board[6]
    end
  end

end

TicTacToe.new.show