defmodule TicTacToe.ConsoleMessages do
  alias TicTacToe.Board, as: Board

  @blank_space "   "
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
    Enum.map(Board.current_marks(board), &status_to_symbol/1)
  end

  defp status_to_symbol(status) do
    case status do
      :player_one -> @player_one_mark
      :player_two -> @player_two_mark
      _ -> @blank_space
    end
  end

end
