defmodule PlayAllGamesAcceptanceTest do
  use ExUnit.Case
  alias TicTacToe.ArtificialIntelligence.ComputerPlayer, as: Player
  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.Core.Rules, as: Rules

  defp conditional_computer_move(board, player) do
    if Rules.in_progress?(board) do
      Board.mark(board, Player.best_spot(board, player), player)
    else
      board
    end
  end

  defp all_computer_moves(boards, player) do
    Enum.map(boards, &conditional_computer_move(&1, player))
  end

  defp conditional_human_move(board, cell, player) do
    if Rules.in_progress?(board) do
      Board.mark(board, cell, player)
    else
      board
    end
  end

  defp all_moves_for_single_board(board, player) do
    Enum.map(Board.remaining_spaces(board), &conditional_human_move(board, &1, player))
  end

  defp all_human_moves(boards, player) do
    Enum.map(boards, &all_moves_for_single_board(&1, player))
  end

  defp single_round_human_first(boards) do
    boards
    |> all_human_moves(:player_one)
    |> List.flatten
    |> all_computer_moves(:player_two)
  end

  defp play_all_human_first do
    [Board.empty_board]
    |> single_round_human_first
    |> single_round_human_first
    |> single_round_human_first
    |> single_round_human_first
    |> single_round_human_first
  end

  defp single_round_computer_first(boards) do
    boards
    |> all_computer_moves(:player_one)
    |> all_human_moves(:player_two)
    |> List.flatten
  end

  defp play_all_computer_first do
    [Board.empty_board]
    |> single_round_computer_first
    |> single_round_computer_first
    |> single_round_computer_first
    |> single_round_computer_first
    |> single_round_computer_first
  end

  test "unbeatable computer players win or tie every possible game (human first)" do
    statuses = Enum.map(play_all_human_first(), fn(x) -> Rules.status(x) end)
    refute :player_one in statuses
  end

  test "unbeatable computer players win or tie every possible game (computer first)" do
    statuses = Enum.map(play_all_computer_first(), fn(x) -> Rules.status(x) end)
    refute :player_two in statuses
  end

end
