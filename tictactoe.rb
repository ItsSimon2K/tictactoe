require "gosu"
Dir[File.join(__dir__, 'lib/**/*.rb')].sort.each { |file| require file }

# Main Window class
class TicTacToe < Gosu::Window

  def initialize
    super(WIN_WIDTH, WIN_HEIGHT, false)

    self.caption = "TicTacToe"

    # Display text's position
    @display_text_pos = [235, 50]

    # Player's Turn
    @player_turn = "O"

    # Winner
    @winner = ""

    # Game condition
    @game = true
    @input_menu = true

    # Array to store match history (string)
    @matchesarr = Array.new()

    # Read match history from text file
    read_file

    # Game board
    @game_board = Board.new()

    # Player name input
    @player1_input = TextInput.new(self, FONT_SMALL, 200, 135, ZOrder::MIDDLE, 250, "Enter name")
    @player2_input = TextInput.new(self, FONT_SMALL, 200, 235, ZOrder::MIDDLE, 250, "Enter name")

    # Done button
    @done_button = Button.new(self, ((WIN_WIDTH / 2) - (130 / 2)), 275, 130, 50, "   Done")

    # Restart button
    @restart_button = Button.new(self, ((WIN_WIDTH / 2) - (130 / 2)), 150, 130, 50, "Play again")
    
    # Exit button
    @exit_button = Button.new(self, ((WIN_WIDTH / 2) - (130 / 2)), 225, 130, 50, "Exit game")
  end

  def draw
    # Background
    Gosu.draw_rect(0, 0, WIN_WIDTH, WIN_HEIGHT, Gosu::Color::GRAY, ZOrder::BACKGROUND)

    if (@game)
      # Display player's turn
      draw_display_text(FONT_LARGE, @player_turn + "\'s Turn", @display_text_pos[0], @display_text_pos[1])
      # Game board
      @game_board.draw()
    end

    if (!@game)
      if @winner == "X" or @winner == "O"
        # Display winner when the game ends and theres no tie
        draw_display_text(FONT_LARGE, @winner + " Wins!", @display_text_pos[0], @display_text_pos[1])
      elsif @winner == ""
        # Display tie when there is no winner
        draw_display_text(FONT_LARGE, "It's a tie!", @display_text_pos[0], @display_text_pos[1])
      end

      if @input_menu
        draw_display_text(FONT_MEDIUM, "Player1's name (O):", 200, 100)
        @player1_input.draw()
        draw_display_text(FONT_MEDIUM, "Player2's name (X):", 200, 200)
        @player2_input.draw()
        @done_button.draw()
      end
      if (!@input_menu)
        # Restart game button
        @restart_button.draw()
        # Exit game button
        @exit_button.draw()
      end
    end

  end

  def update
    @player1_input.update()
    @player2_input.update()
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    case id
    when Gosu::MsLeft
      if (@game)
        for i in 0..8
          if @game_board.mouse_over_button?(mouse_x, mouse_y, @game_board.button_pos[i][0], @game_board.button_pos[i][1])
            if @game_board.board[i] != "O" &&  @game_board.board[i] != "X"
              @player_turn = handle_turn(@player_turn, i)
            end
          end
        end
      end
    end

    if (!@game)
      if @input_menu
        @player1_input.button_down(id)
        @player2_input.button_down(id)
        if @done_button.button_down(id)
          
        end
      end

      if (!@input_menu)
        # Restart game button
        if @restart_button.button_down(id)
          restart_game()
        end
        # Exit game button
        if @exit_button.button_down(id)
          close
        end
      end
    end
  end

  def read_file
    match_file = File.new("matches.txt", "r")
    no_of_match = match_file.gets.chomp.to_i
    if no_of_match != nil
      
      for i in 0..no_of_match - 1
        match = match_file.gets
        matchesarr << match
      end
    end
    match_file.close
  end

  def draw_display_text(font, text, x, y)
    font.draw_text(text, x, y, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)
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
      @game_board.board[button] = "O"
    when "X"
      @game_board.board[button] = "X"
    end
  end

  def check_for_winner
    diagonal_winner = check_diagonal(@game_board.board)
    vertical_winner = check_vertical(@game_board.board)
    horizontal_winner = check_horizontal(@game_board.board)
    if diagonal_winner
      @winner = diagonal_winner
    elsif vertical_winner
      @winner = vertical_winner
    elsif horizontal_winner
      @winner = horizontal_winner
    else
      if !(@game_board.board.include? "")
        @winner = ""
        @game = false
      end
    end
  end

  # Check both diagonal
  def check_diagonal(board)
    diagonal1 = board[0] == board[4] && 
                board[0] == board[8] && 
                board[0] != ""

    diagonal2 = board[2] == board[4] && 
                board[2] == board[6] && 
                board[2] != ""

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
    col1 = board[0] == board[3] && 
           board[0] == board[6] && 
           board[0] != ""

    col2 = board[1] == board[4] && 
           board[1] == board[7] && 
           board[1] != ""

    col3 = board[2] == board[5] && 
           board[2] == board[8] && 
           board[2] != ""

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
    row1 = board[0] == board[1] && 
           board[0] == board[2] && 
           board[0] != ""
           
    row2 = board[3] == board[4] && 
           board[3] == board[5] && 
           board[3] != ""

    row3 = board[6] == board[7] && 
           board[6] == board[8] && 
           board[6] != ""

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

  def restart_game
    @game_board.board = ["", "", "",
                         "", "", "",
                         "", "", ""]
    @game = true
    @player_turn = "O"
    @winner = ""
  end
end

TicTacToe.new.show