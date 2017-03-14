defmodule TicTacToe.Console.HumanPlayer do
  alias TicTacToe.Console.ConsoleMessages, as: Messages
  alias TicTacToe.Console.MoveSanitizer, as: Sanitizer
  alias TicTacToe.Console.MoveValidator, as: Validator
  alias TicTacToe.Core.Board, as: Board

  def get_move(board, player), do: get_move(board, player, &IO.gets/1)

  def get_move(board, player, input_function) do
    formatted_input = format_input(input_function)
    formatted_marks = format_marks(board)
    case Validator.validate_cell(formatted_input, formatted_marks) do
      :valid ->
        IO.puts Messages.move_confirmation(formatted_input)
        formatted_input
      :too_small ->
        IO.puts Messages.input_too_small
        get_move(board, player, input_function)
      :too_large ->
        IO.puts Messages.input_too_large
        get_move(board, player, input_function)
      :cell_taken ->
        IO.puts Messages.input_already_taken
        get_move(board, player, input_function)
      :not_an_integer ->
        IO.puts Messages.choose_valid_cell
        get_move(board, player, input_function)
    end
  end

  defp format_input(input_function) do
    Messages.move_prompt
    |> input_function.()
    |> Sanitizer.sanitize
    |> string_to_integer
  end

  defp string_to_integer(input) do
    if integer?(input), do: elem(Integer.parse(input), 0)
  end

  defp integer?(input) do
    if Validator.is_empty_string?(input) do
      false
    else
      !Validator.contains_letter?(input) and
      !Validator.contains_decimal?(input) and
      !Validator.only_newline?(input)
    end
  end

  defp format_marks(board) do
    board
    |> Board.current_marks
    |> List.to_tuple
  end

end
