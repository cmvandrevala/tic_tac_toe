defmodule TicTacToe.Game do
  alias TicTacToe.Board, as: Board

  def current_player(board), do: if new_round?(board), do: :player_one, else: :player_two

  defp new_round?(board), do: rem(Board.number_of_filled_cells(board), 2) == 0

  def move(cell), do: move(Board.empty_board, cell)
  def move(board, cell), do: Board.mark(board, cell, current_player(board))

end
