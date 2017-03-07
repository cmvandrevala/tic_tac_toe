defmodule TicTacToe.Board do

  @number_of_cells 9

  def empty_board, do: %{}

  def mark(board, cell, player), do: Map.put(board, cell, player)

  def cell_status(board, cell), do: Map.get(board, cell) || :empty

  def filled?(board), do: number_of_filled_cells(board) == @number_of_cells

  def empty?(board), do: number_of_filled_cells(board) == 0

  def number_of_filled_cells(board), do: Kernel.map_size(board)

end
