defmodule TicTacToe.ComputerPlayer do
  alias TicTacToe.Board, as: Board

  def first_available_spot(board) do
    [head | tail] = empty_spaces(board)
    elem(head, 1)
  end

  defp empty_spaces(board) do
    Board.current_marks(board)
    |> Enum.with_index
    |> Enum.filter(fn {status, indx} -> status == :empty end)
  end

end
