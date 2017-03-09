defmodule TicTacToe.ArtificialIntelligence.ComputerPlayer do
  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.Core.Rules, as: Rules

  def first_available_spot(board) do
    [head | _] = empty_spaces(board)
    elem(head, 1)
  end

  defp empty_spaces(board) do
    Board.current_marks(board)
    |> Enum.with_index
    |> Enum.filter(fn {status, _} -> status == :empty end)
  end

  def utility(board, player) do
    cond do
      Rules.status(board) == player -> 10
      Rules.status(board) == :tie -> 0
      Rules.status(board) == :in_progress -> nil
      true -> -10
    end
  end

  def best_spot(board) do
    cond do
      first_turn?(board) -> 0
      second_turn?(board) && center_taken?(board) -> 0
      true -> 4
    end
  end

  defp first_turn?(board) do
    Board.number_of_filled_cells(board) == 0
  end

  defp second_turn?(board) do
    Board.number_of_filled_cells(board) == 1
  end

  defp center_taken?(board) do
    Board.cell_status(board, 4) != :empty
  end

end
