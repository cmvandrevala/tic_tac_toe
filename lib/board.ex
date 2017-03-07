defmodule TicTacToe.Board do

  @number_of_cells 9

  def empty_board, do: %{}

  def mark(board, cell, player), do: Map.put(board, cell, player)

  def cell_status(board, cell), do: Map.get(board, cell) || :empty

  def filled?(board), do: Kernel.map_size(board) == @number_of_cells

  def empty?(board), do: Kernel.map_size(board) == 0

end
