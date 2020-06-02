require "gosu"

module ZOrder
  BACKGROUND, BOTTOM, MIDDLE, TOP = *0..3
end

WIN_WIDTH = 640
WIN_HEIGHT = 400

class Button
  attr_accessor :button_x, :button_y, :button_width, :button_height, :button_color, :button_zorder, :text, :text_content, :text_color, :text_zorder

  def initialize(button_x, button_y, button_width, button_height, button_color, button_zorder, text, text_content, text_color, text_zorder)
    @button_x = button_x
    @button_y = button_y
    @button_width = button_width
    @button_height = button_height
    @button_color = button_color
    @button_zorder = button_zorder
    @text = text
    @text_content = text_content
    @text_color = text_color
    @text_zorder = text_zorder
  end

  def draw
    Gosu.draw_rect(@button_x, @button_y, @button_width, @button_height, @button_color, @button_zorder)
    @text.draw_text(@text_content, @button_x + (@button_width / 8), @button_y + (@button_height / 4), @text_zorder, 1, 1, @text_color, mode=:default)
  end

  def mouse_over_button?(mouse_x, mouse_y)
    if ((mouse_x > @button_x and mouse_x < @button_x + @button_width) and (mouse_y > @button_y and mouse_y < @button_y + @button_height)) 
      true
    else
      false
    end
  end
end

class Sign
  attr_accessor

  def initialize

  end

end

class TicTacToe < Gosu::Window

  def initialize
    super(WIN_WIDTH, WIN_HEIGHT, false)
    @text = Gosu::Font.new(50)
    @button_text = Gosu::Font.new(25)
    # Player's Turn
    @player_turn = "O"
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
    # Top right Coords of each button on the board
    @button_pos = [[200, 95],[280, 95],[360, 95],
                  [200, 175],[280, 175],[360, 175],
                  [200, 255],[280, 255],[360, 255]]
    # Button's width & height on the board
    @button_width = 80
    @button_height = 80
    # Restart button
    @restart_button = Button.new(250, 150, 130, 50, Gosu::Color::RED, ZOrder::BOTTOM, @button_text, "Play again", Gosu::Color::WHITE, ZOrder::MIDDLE)
    @exit_button = Button.new(250, 225, 130, 50, Gosu::Color::RED, ZOrder::BOTTOM, @button_text, "Exit game", Gosu::Color::WHITE, ZOrder::MIDDLE)
  end

  def draw
    if (@game)
      # Display player's turn
      @text.draw_text((@player_turn + "\'s Turn"), 230, 50, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)

      # Game board
      draw_rect(200, 95, 240, 240, Gosu::Color::RED, ZOrder::BOTTOM)
      draw_line(200, 175, Gosu::Color::BLACK, 440, 175, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
      draw_line(200, 255, Gosu::Color::BLACK, 440, 255, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
      draw_line(280, 95, Gosu::Color::BLACK, 280, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)
      draw_line(360, 95, Gosu::Color::BLACK, 360, 335, Gosu::Color::BLACK, ZOrder::MIDDLE, mode=:default)

      # Check the board and draw sign on the screen
      for i in 0..8
        check_and_draw(i)
      end
    end

    if (!@game)
      if @winner == "X" or @winner == "O"
        # Display winner when the game ends and theres no tie
        @text.draw_text((@winner + " Won!"), 230, 50, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)
      elsif @winner == ""
        # Display tie if there is no winner
        @text.draw_text(("It's a tie!"), 230, 50, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)
      end

      # Restart game button
      @restart_button.draw()
      # Exit game button
      @exit_button.draw()
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

      if (@game)
        for i in 0..8
          if mouse_over_button?(mouse_x, mouse_y, @button_pos[i][0], @button_pos[i][1], @button_width, @button_height)
            if @board[i] != "O" and  @board[i] != "X"
              @player_turn = handle_turn(@player_turn, i)
            end
          end
        end
      end

      if (!@game)
        # Reset game button
        if @restart_button.mouse_over_button?(mouse_x, mouse_y)
          @board = ["", "", "",
                    "", "", "",
                    "", "", ""]
          @game = true
          @player_turn = "O"
          @winner = ""
        end
        # Exit game button
        if @exit_button.mouse_over_button?(mouse_x, mouse_y)
          close
        end
      end
      
    end
  end

  def mouse_over_button?(mouse_x, mouse_y, button_x, button_y, button_width, button_height)
    if ((mouse_x > button_x and mouse_x < button_x + button_width) and (mouse_y > button_y and mouse_y < button_y + button_height)) 
      true
    else
      false
    end
  end

  # Check the game board and draw either "X" or "O" on the screen 
  def check_and_draw(button)
    case @board[button]
    when "O"
      @nought.draw(@button_pos[button][0], @button_pos[button][1], ZOrder::TOP)
    when "X"
      @cross.draw(@button_pos[button][0], @button_pos[button][1], ZOrder::TOP)
    end
  end

  def handle_turn(player_turn, button)
    place_sign(player_turn,button)
    check_for_winner()
    switch_player_turn(player_turn)
  end

  # Check the playerTurn then switch the turn to the other player
  def switch_player_turn(player_turn)
    case player_turn
    when "O"
      player_turn = "X"
    when "X"
      player_turn = "O"
    end
    return player_turn
  end

  # Check the playerTurn then insert either "X" or "O" into the game board
  def place_sign(player_turn, button)
    case player_turn
    when "O"
      @board[button] = "O"
    when "X"
      @board[button] = "X"
    end
  end

  def check_for_winner
    diagonal_winner = check_diagonal(@board)
    vertical_winner = check_vertical(@board)
    horizontal_winner = check_horizontal(@board)
    if diagonal_winner
      @winner = diagonal_winner
    elsif vertical_winner
      @winner = vertical_winner
    elsif horizontal_winner
      @winner = horizontal_winner
    else
      if !(@board.include? "")
        @winner = ""
        @game = false
      end
    end
  end

  # Check both diagonal
  def check_diagonal(board)
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
  def check_vertical(board)
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
  def check_horizontal(board)
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