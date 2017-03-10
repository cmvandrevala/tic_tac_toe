defmodule TicTacToe.ArtificialIntelligence.ComputerPlayer do
  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.ArtificialIntelligence.GameTree, as: Tree
  alias TicTacToe.Core.Rules, as: Rules
  require Integer

  def first_available_spot(board) do
    [head | _] = empty_spaces(board)
    elem(head, 1)
  end

  defp empty_spaces(board) do
    Board.current_marks(board)
    |> Enum.with_index
    |> Enum.filter(fn {status, _} -> status == :empty end)
  end

  def utility(board, player) do
    cond do
      Rules.status(board) == player -> 10
      Rules.status(board) == :tie -> 0
      Rules.status(board) == :in_progress -> nil
      true -> -10
    end
  end

  def game_tree(board, player) do
    game_tree(board, player, Tree.node, 0)
  end

  def game_tree(board, player, node, level) do
    if Board.filled?(board), do: node, else: build_tree(board, player, node, level, Board.remaining_spaces(board))
  end

  defp build_tree(board, player, node, level, remaining_spaces) do
    [space | tail] = remaining_spaces
    marked_board = Board.mark(board, space, player)
    utility = utility(marked_board, player)
    value = if Integer.is_even(level), do: utility, else: -utility

    child = if(Rules.in_progress?(marked_board)) do
      game_tree(marked_board, opponent(player), Tree.node(nil, space), level + 1)
    else
      Tree.node(value, space)
    end

    if Kernel.length(tail) > 0 do
      build_tree(board, player, Tree.add_child(node, child), level, tail)
    else
      Tree.add_child(node, child)
    end
  end

  def best_spot(board) do
    cond do
      Board.empty?(board) -> 0
      second_turn?(board) && center_taken?(board) -> 0
      true -> 4
    end
  end

  defp opponent(player), do: if player == :player_one, do: :player_two, else: :player_one

  defp second_turn?(board) do
    Board.number_of_filled_cells(board) == 1
  end

  defp center_taken?(board) do
    Board.cell_status(board, 4) != :empty
  end

end
