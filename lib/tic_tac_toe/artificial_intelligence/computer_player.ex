defmodule TicTacToe.ArtificialIntelligence.ComputerPlayer do
  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.ArtificialIntelligence.GameTree, as: Tree
  alias TicTacToe.Core.Rules, as: Rules
  require Integer

  def first_available_spot(board, _) do
    [head | _] = empty_spaces(board)
    elem(head, 1)
  end

  def best_spot(board, player) do
    cond do
      Board.number_of_filled_cells(board) == 0 -> 0
      second_turn?(board) && center_taken?(board) -> 0
      second_turn?(board) -> 4
      true -> search_for_best_spot(board, player)
    end
  end

  def search_for_best_spot(board, player) do
    board
    |> find_utilities_for_remaining_cells(player)
    |> extract_largest_utility
    |> elem(0)
  end

  defp empty_spaces(board) do
    Board.current_marks(board)
    |> Enum.with_index
    |> Enum.filter(fn {status, _} -> status == :empty end)
  end

  defp find_utilities_for_remaining_cells(board, player) do
    Enum.map(Keyword.values(empty_spaces(board)), fn(x) -> {x, minimax(board, x, player)} end)
  end

  defp extract_largest_utility(utilities_for_remaining_cells) do
    Enum.max_by(utilities_for_remaining_cells, fn(x) -> elem(x, 1) end)
  end

  defp minimax(board, cell, player) do
    marked_board = Board.mark(board, cell, player)
    if(Rules.in_progress?(marked_board)) do
      -1*(Tree.score(game_tree(marked_board, opponent(player))))
    else
      utility(marked_board, player)
    end
  end

  def utility(board, player) do
    cond do
      Rules.status(board) == player -> 10
      Rules.status(board) == :tie -> 0
      Rules.status(board) == :in_progress -> nil
      true -> -10
    end
  end

  def game_tree(board, player),
    do: game_tree(board, player, Tree.node, 0)
  def game_tree(board, player, node, level) do
    if Board.filled?(board), do: node, else: build_tree(board, player, node, level, Board.remaining_spaces(board))
  end

  defp build_tree(board, player, node, level, remaining_spaces) do
    [space | tail] = remaining_spaces
    marked_board = Board.mark(board, space, player)
    child = child(marked_board, player, space, level)
    append_node(board, player, node, child, level, tail)
  end

  defp append_node(board, player, node, child, level, tail) do
    if Kernel.length(tail) > 0 do
      build_tree(board, player, Tree.add_child(node, child), level, tail)
    else
      Tree.add_child(node, child)
    end
  end

  defp child(marked_board, player, space, level) do
    if(Rules.in_progress?(marked_board)) do
      game_tree(marked_board, opponent(player), Tree.node(nil, space), level + 1)
    else
      Tree.node(value(utility(marked_board, player), level), space)
    end
  end

  defp value(utility, level), do: if Integer.is_even(level), do: utility, else: -utility

  defp opponent(player), do: if player == :player_one, do: :player_two, else: :player_one

  defp second_turn?(board), do: Board.number_of_filled_cells(board) == 1

  defp center_taken?(board), do: Board.cell_status(board, 4) != :empty

end
