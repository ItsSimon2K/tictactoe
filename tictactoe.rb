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
    @player_turn = ["O", "X"][rand(0..1)]

    # Winner
    @winner = ""

    # Use to check for game condition
    @game = true

    # Use to change menu depend on which button is clicked
    @input_menu = true
    @match_results_menu = false

    # Use to display message if the input field is empty
    @player1_field_empty = false
    @player2_field_empty = false

    # Array to store match results (string)
    @matchesarr = Array.new()

    # Read match results from text file and store it in the @matchesarr
    read_file

    # Game board
    @game_board = Board.new()

    # Player1 name input
    @player1_input = TextInput.new(self, 
                                   FONT_SMALL, 
                                   200, 
                                   135, 
                                   ZOrder::MIDDLE, 
                                   250, 
                                   "Enter name")\
    
    # Player2 name input
    @player2_input = TextInput.new(self, 
                                   FONT_SMALL, 
                                   200, 
                                   235, 
                                   ZOrder::MIDDLE, 
                                   250, 
                                   "Enter name")

    # Done button
    @done_button = Button.new(self, 
                             ((WIN_WIDTH / 2) - (MENU_BUTTON_WIDTH / 2)), 
                             275, 
                             MENU_BUTTON_WIDTH, 
                             MENU_BUTTON_HEIGHT, 
                             "Done")

    # Match results button
    @match_results_button = Button.new(self, 
                                      ((WIN_WIDTH / 2) - (200 / 2)), 
                                      WIN_HEIGHT - 60, 
                                      200, 
                                      40, 
                                      "Match Results")

    # Back button
    @back_button = Button.new(self, 
                              ((WIN_WIDTH / 2) - (MENU_BUTTON_WIDTH / 2)), 
                              280, 
                              MENU_BUTTON_WIDTH, 
                              MENU_BUTTON_HEIGHT, 
                              "Back")

    # Restart button
    @restart_button = Button.new(self, 
                                 ((WIN_WIDTH / 2) - (MENU_BUTTON_WIDTH / 2)), 
                                 150, 
                                 MENU_BUTTON_WIDTH, 
                                 MENU_BUTTON_HEIGHT, 
                                 "Play again")

    # Exit button
    @exit_button = Button.new(self, 
                              ((WIN_WIDTH / 2) - (MENU_BUTTON_WIDTH / 2)), 
                              225, 
                              MENU_BUTTON_WIDTH, 
                              MENU_BUTTON_HEIGHT, 
                              "Exit game")
  end

  def draw
    # Background
    Gosu.draw_rect(0, 0, WIN_WIDTH, WIN_HEIGHT, Gosu::Color::GRAY, ZOrder::BACKGROUND)

    if (@game)
      # Draw board and Display text that display player's turn
      draw_game
    end

    if (!@game)
      if @input_menu
        # Draw Display text that display the result of the match
        draw_match_result_text
        # Draw Text input for players' name
        draw_textinput_menu
      else(!@input_menu)
        if (!@match_results_menu)
          # Draw Display text that display the result of the match
          draw_match_result_text
          # Draw endgame menu
          draw_endgame_menu
        else
          # Draw a menu displaying all the results of previous matches 
          draw_match_results
        end
      end
    end
  end

  def update
    # Update the text input
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
        # Check mouse event on text input
        @player1_input.button_down(id)
        @player2_input.button_down(id)
        player1_name = @player1_input.text
        player2_name = @player2_input.text

        if @done_button.button_down(id)
          # Only allow to proceed when both input fields are filled
          if player1_name.length > 0 && player2_name.length > 0
            match_result = get_match_result(player1_name, player2_name)
            # Insert the result (string) into the array
            @matchesarr << match_result
            # Write the results in the array into the text file
            write_file
            @input_menu = false
          else
            # Display msg telling the players to enter their name if they leave the input field empty
            if player1_name.length <= 0
              @player1_field_empty = true
            else
              @player1_field_empty = false
            end
            if player2_name.length <= 0
              @player2_field_empty = true
            else
              @player2_field_empty = false
            end
          end
        end
      else
        if (!@match_results_menu)
          # Restart game button
          if @restart_button.button_down(id)
            restart_game()
          end
          # Exit game button
          if @exit_button.button_down(id)
            close
          end
          # Match results button
          if @match_results_button.button_down(id)
            @match_results_menu = true
          end
        else
          # Back button
          if @back_button.button_down(id)
            @match_results_menu = false
          end
        end
      end
    end
  end

  # Read the text file
  def read_file
    match_file = File.new("matches.txt", "r")
    no_of_match = match_file.gets.chomp.to_i
    if no_of_match != nil
      for i in 0..no_of_match - 1
        match_result = match_file.gets
        @matchesarr << match_result
      end
    end
    match_file.close
  end

  # Update the text file
  def write_file
    match_file = File.new("matches.txt", "w")
    no_of_match = @matchesarr.length
    match_file.puts(no_of_match.to_s)
    for i in 0..no_of_match - 1
      match_file.puts(@matchesarr[i])
    end
    match_file.close
  end

  # Draw display text
  def draw_display_text(font, text, x, y)
    font.draw_text(text, x, y, ZOrder::MIDDLE, 1, 1, Gosu::Color::WHITE, mode=:default)
  end

  # Display all previous match results
  def draw_match_results
    draw_display_text(FONT_LARGE, "Match History", 185, 50)
    y = 100
    for i in 0..@matchesarr.length - 1
      draw_display_text(FONT_SMALL, @matchesarr[i], 240, y)
      y += 20
    end
    @back_button.draw()
  end

  def draw_game
    # Display player's turn
    draw_display_text(FONT_LARGE, @player_turn + "\'s Turn", @display_text_pos[0], @display_text_pos[1])
    # Game board
    @game_board.draw()
  end

  def draw_match_result_text
    if @winner == "X" or @winner == "O"
      # Display winner when the game ends and theres no tie
      draw_display_text(FONT_LARGE, @winner + " Wins!", @display_text_pos[0], @display_text_pos[1])
    elsif @winner == ""
      # Display tie when there is no winner
      draw_display_text(FONT_LARGE, "It's a tie!", @display_text_pos[0], @display_text_pos[1])
    end
  end

  def draw_textinput_menu
    # Draw text & text input for player 1
    draw_display_text(FONT_MEDIUM, "Player1's name (O):", 200, 100)
    @player1_input.draw()
    # Only display when the input field is empty
    if @player1_field_empty
      draw_display_text(FONT_SMALL, "Please enter name", 460, 135)
    end
    # Draw text & text input for player 2
    draw_display_text(FONT_MEDIUM, "Player2's name (X):", 200, 200)
    @player2_input.draw()
    # Only display when the input field is empty
    if @player2_field_empty
      draw_display_text(FONT_SMALL, "Please enter name", 460, 235)
    end
    # Done button
    @done_button.draw()
  end

  def draw_endgame_menu
    @match_results_button.draw()
    # Restart game button
    @restart_button.draw()
    # Exit game button
    @exit_button.draw()
  end
  
  def get_match_result(player1_name, player2_name)
    if @winner == "O"
      match_result = "#{player1_name}(win) vs #{player2_name}"
    elsif @winner == "X"
      match_result = "#{player1_name} vs #{player2_name}(win)"
    else
      match_result = "#{player1_name} vs #{player2_name} (tie)"
    end
    return match_result
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

  # Restart game
  def restart_game
    @game_board.board = ["", "", "",
                         "", "", "",
                         "", "", ""]
    @game = true
    @input_menu = true
    @player_turn = ["O", "X"][rand(0..1)]
    @winner = ""
    self.text_input = nil
    @player1_input.text = ""
    @player2_input.text = ""
  end
end

TicTacToe.new.show