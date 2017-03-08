defmodule TicTacToe.Rules do
  alias TicTacToe.Board, as: Board

  @players [:player_one, :player_two]

  def in_progress?(board), do: status(board) == :in_progress

  def status(board), do: board_state(Board.current_marks(board))

  defp board_state([x, x, x,
                    _, _, _,
                    _, _, _]) when x in @players, do: x

  defp board_state([_, _, _,
                    x, x, x,
                    _, _, _]) when x in @players, do: x

  defp board_state([_, _, _,
                    _, _, _,
                    x, x, x]) when x in @players, do: x

  defp board_state([x, _, _,
                    x, _, _,
                    x, _, _]) when x in @players, do: x

  defp board_state([_, x, _,
                    _, x, _,
                    _, x, _]) when x in @players, do: x

  defp board_state([_, _, x,
                    _, _, x,
                    _, _, x]) when x in @players, do: x

  defp board_state([x, _, _,
                    _, x, _,
                    _, _, x]) when x in @players, do: x

  defp board_state([_, _, x,
                    _, x, _,
                    x, _, _]) when x in @players, do: x

  defp board_state(current_marks),
    do: if Enum.member?(current_marks, :empty), do: :in_progress, else: :tie

end
