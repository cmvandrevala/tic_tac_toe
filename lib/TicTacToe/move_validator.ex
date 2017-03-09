defmodule TicTacToe.MoveValidator do
  alias TicTacToe.Board, as: Board

  @board_size Board.number_of_cells

  def contains_decimal?(raw_input), do: String.contains?(raw_input, ".")

  def contains_letter?(raw_input), do: Regex.match?(~r/[a-z]/, raw_input)

  def only_newline?(raw_input), do: Regex.match?(~r/^[\s]$/, raw_input)

  def validate_cell(move, _) when is_nil(move),
    do: :not_an_integer
  def validate_cell(move, _) when move < 0,
    do: :too_small
  def validate_cell(move, _) when move > @board_size-1,
    do: :too_large
  def validate_cell(move, marks) when elem(marks, move) !== :empty,
    do: :cell_taken
  def validate_cell(_, _),
    do: :valid

end
