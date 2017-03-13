defmodule TicTacToe.Console.ConsoleMessages do
  alias TicTacToe.Core.Board, as: Board

  @player_one_mark " X "
  @player_two_mark " O "
  @vertical_bar "|"
  @horizontal_bar "\n-----------\n"
  @newline "\n"

  def formatted_board(board) do
    Enum.join([Enum.at(marks(board), 0), @vertical_bar, Enum.at(marks(board), 1), @vertical_bar, Enum.at(marks(board), 2),
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

  def player_one_turn, do: "It is player one's turn."

  def player_two_turn, do: "It is player two's turn."

  def game_over, do: "The game is over."

  def input_too_small, do: "That cell value is too small!"

  def input_too_large, do: "That cell value is too large!"

  def input_already_taken, do: "That cell has already been taken!"

  def choose_valid_cell, do: "You need to enter an integer between 0 and 8."

  def move_prompt, do: "Enter your move: "

  def move_confirmation(cell), do: "You are moving in cell #{cell}."

  def game_begins_now, do: "\nThe game will begin now!"

  def menu_quit, do: "\nGoodbye! Thanks for playing!"

  def invalid_menu_input, do: "\nThat is not a valid input!"

  def play_again_prompt, do: "\nWould you like to play again? Yes (Y) or No (N)? "

  def select_player(player) do
    if player == :player_one do
      "\nPlease select player one."
    else
      "\nPlease select player two."
    end
  end

  def game_status(status) do
    case status do
      :player_one -> "Player one wins!"
      :player_two -> "Player two wins!"
      :tie -> "The game has ended in a tie."
    end
  end

  def menu_welcome do
    Enum.join(["\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
               "| Welcome to Elixir Tic-Tac-Toe! |",
               "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"], @newline)
  end

  def player_type_prompt do
    Enum.join(["\nThe player types are:",
               "(1) Human",
               "(2) Easy Computer",
               "(3) Hard Computer",
               "",
               "What kind of player would you like (1, 2, or 3)? "], @newline)
  end

end
