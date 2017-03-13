defmodule TicTacToe.Core.Board do

  @number_of_cells 9

  def empty_board, do: %{}

  def mark(board, cell, player), do: Map.put(board, cell, player)

  def cell_status(board, cell), do: Map.get(board, cell) || :empty

  def number_of_filled_cells(board), do: Kernel.map_size(board)

  def current_marks(board),
    do: Enum.map(cell_range(), fn x -> board[x] || :empty end)

  def number_of_cells, do: @number_of_cells

  def remaining_spaces(board),
    do: Enum.to_list(cell_range()) -- indices_of_filled_cells(board)

  def filled?(board), do: number_of_filled_cells(board) == @number_of_cells

  defp indices_of_filled_cells(board), do: Enum.map(board, fn {k,_} -> k end)

  defp cell_range, do: 0..@number_of_cells - 1

end
