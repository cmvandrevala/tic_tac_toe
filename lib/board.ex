defmodule TicTacToe.Board do

  def empty_board, do: %{}

  def mark(player, cell, board), do: Map.put(board, cell, player)

  def cell_status(cell, board), do: Map.get(board, cell) || :empty

end
