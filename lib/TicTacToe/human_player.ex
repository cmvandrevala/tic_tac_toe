defmodule TicTacToe.HumanPlayer do
  alias TicTacToe.Board, as: Board
  alias TicTacToe.ConsoleMessages, as: Messages
  alias TicTacToe.MoveValidator, as: MoveValidator

  def get_move(board), do: get_move(board, &IO.gets/1)

  def get_move(board, input_function) do
    formatted_input = format_input(input_function)
    formatted_marks = format_marks(board)
    case MoveValidator.validate(formatted_input, formatted_marks) do
      :valid ->
        IO.puts Messages.move_confirmation(formatted_input)
        formatted_input
      :too_small ->
        IO.puts Messages.input_too_small
        get_move(board, input_function)
      :too_large ->
        IO.puts Messages.input_too_large
        get_move(board, input_function)
      :cell_taken ->
        IO.puts Messages.input_already_taken
        get_move(board, input_function)
      _ ->
        IO.puts Messages.choose_valid_cell
        get_move(board, input_function)
    end
  end

  defp format_input(input_function) do
    input = input_function.(Messages.move_prompt)
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
