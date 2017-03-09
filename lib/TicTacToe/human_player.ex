defmodule TicTacToe.HumanPlayer do
  alias TicTacToe.Board, as: Board
  alias TicTacToe.MoveValidator, as: MoveValidator

  def get_move(board), do: get_move(board, &IO.gets/1)

  def get_move(board, input_function) do
    formatted_input = format_input(input_function)
    formatted_marks = format_marks(board)
    case MoveValidator.validate(formatted_input, formatted_marks) do
      :valid ->
        IO.puts "You are moving in cell #{formatted_input}."
        formatted_input
      :too_small ->
        IO.puts "That cell value is too small!"
        get_move(board, input_function)
      :too_large ->
        IO.puts "That cell value is too large!"
        get_move(board, input_function)
      :cell_taken ->
        IO.puts "That cell has already been taken!"
        get_move(board, input_function)
      _ ->
        IO.puts "You need to enter an integer between 0 and 8."
        get_move(board, input_function)
    end
  end

  defp format_input(input_function) do
    input = input_function.("Enter your move: ")
    unless not_an_integer(input), do: elem(Integer.parse(input), 0)
  end

  defp not_an_integer(input) do
    Regex.match?(~r/[a-z]/, input) ||
    Regex.match?(~r/^[\s]$/, input) ||
    String.contains?(input, ".")
  end

  defp format_marks(board) do
    board
    |> Board.current_marks
    |> List.to_tuple
  end

end
