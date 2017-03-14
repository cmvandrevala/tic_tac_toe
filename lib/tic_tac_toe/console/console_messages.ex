defmodule TicTacToe.Console.ConsoleMessages do
  alias TicTacToe.Core.Board, as: Board

  @player_one_mark [IO.ANSI.red, " X ", IO.ANSI.reset]
  @player_two_mark [IO.ANSI.green, " O ", IO.ANSI.reset]
  @vertical_bar "|"
  @horizontal_bar "\n-----------\n"
  @newline "\n"

  def formatted_board(board) do
    Enum.join([@newline,
               Enum.at(marks(board), 0), @vertical_bar, Enum.at(marks(board), 1), @vertical_bar, Enum.at(marks(board), 2),
               @horizontal_bar,
               Enum.at(marks(board), 3), @vertical_bar, Enum.at(marks(board), 4), @vertical_bar, Enum.at(marks(board), 5),
               @horizontal_bar,
               Enum.at(marks(board), 6), @vertical_bar, Enum.at(marks(board), 7), @vertical_bar, Enum.at(marks(board), 8),
               @newline], "")
  end

  defp marks(board) do
    Board.current_marks(board)
    |> Enum.with_index
    |> Enum.map(&status_to_symbol/1)
  end

  defp status_to_symbol({status, indx}) do
    case status do
      :player_one -> @player_one_mark
      :player_two -> @player_two_mark
      :empty -> " #{indx} "
    end
  end

  def choose_valid_cell,
    do: Enum.join([@newline, "You need to enter an integer between 0 and 8."], "")

  def game_begins_now,
    do: Enum.join([@newline, "The game will begin now!"], "")

  def game_over,
    do: Enum.join([@newline, "The game is over."], "")

  def input_already_taken,
    do: Enum.join([@newline, "That cell has already been taken!"], "")

  def input_too_large,
    do: Enum.join([@newline, "That cell value is too large!"], "")

  def input_too_small,
    do: Enum.join([@newline, "That cell value is too small!"], "")

  def invalid_menu_input,
    do: Enum.join([@newline, "That is not a valid input!"], "")

  def menu_quit,
    do: Enum.join([@newline, "Goodbye! Thanks for playing!"], "")

  def move_confirmation(cell),
    do: Enum.join([@newline, "You are moving in cell #{cell}."], "")

  def move_prompt,
    do: Enum.join([@newline, "Enter your move: "], "")

  def play_again_prompt,
    do: Enum.join([@newline, "Would you like to play again? Yes (Y) or No (N)? "], "")

  def player_one_turn,
    do: Enum.join([@newline, "It is player one's turn."], "")

  def player_two_turn,
    do: Enum.join([@newline, "It is player two's turn."], "")

  def game_status(status) do
    case status do
      :player_one ->
        Enum.join([@newline, "Player one wins!"], "")
      :player_two ->
        Enum.join([@newline, "Player two wins!"], "")
      :tie ->
        Enum.join([@newline, "The game has ended in a tie."], "")
    end
  end

  def menu_welcome do
    Enum.join(["",
               "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
               "| Welcome to Elixir Tic-Tac-Toe! |",
               "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"], @newline)
  end

  def player_type_prompt do
    Enum.join(["",
               "The player types are:",
               "(1) Human",
               "(2) Easy Computer",
               "(3) Hard Computer",
               "",
               "What kind of player would you like (1, 2, or 3)? "], @newline)
  end

  def select_player(player) do
    if player == :player_one do
      Enum.join([@newline, "Please select player one."], "")
    else
      Enum.join([@newline, "Please select player two."], "")
    end
  end

end
