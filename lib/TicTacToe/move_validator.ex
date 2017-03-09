defmodule TicTacToe.MoveValidator do
  alias TicTacToe.Board, as: Board

  @board_size Board.number_of_cells

  def validate(move, _) when is_nil(move), do: :is_nil

  def validate(move, _) when is_bitstring(move), do: :is_string

  def validate(move, _) when is_float(move), do: :is_float

  def validate(move, _) when move < 0, do: :too_small

  def validate(move, _) when move > @board_size-1, do: :too_large

  def validate(move, marks) when elem(marks, move) !== :empty, do: :cell_taken

  def validate(_, _), do: :valid

end
