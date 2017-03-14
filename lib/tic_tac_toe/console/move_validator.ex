defmodule TicTacToe.Console.MoveValidator do
  alias TicTacToe.Core.Board, as: Board

  @board_size Board.number_of_cells

  def contains_decimal?(raw_input), do: String.contains?(raw_input, ".")

  def contains_letter?(raw_input), do: Regex.match?(~r/[a-z]/, raw_input)

  def only_newline?(raw_input), do: Regex.match?(~r/^[\s]$/, raw_input)

  def is_empty_string?(raw_input), do: raw_input == ""

  def validate_cell(move, marks) do
    cond do
      is_nil(move) -> :not_an_integer
      move == "" -> :not_an_integer
      move < 0 -> :too_small
      move > @board_size - 1 -> :too_large
      elem(marks, move)!== :empty -> :cell_taken
      true -> :valid
    end
  end

end
