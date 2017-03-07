defmodule GameTest do
  use ExUnit.Case
  doctest TicTacToe.Game

  setup do
    {:ok, empty: TicTacToe.Board.empty_board}
  end

  describe "the current player" do

    test "is :player_one on an empty board" do
      assert TicTacToe.Game.current_player(TicTacToe.Board.empty_board) == :player_one
    end

    test "is :player_two if player one has taken a single turn", context do
      marked_board = TicTacToe.Board.mark(context[:empty], 0, :player_one)
      assert TicTacToe.Game.current_player(marked_board) == :player_two
    end

    test "is :player_one if four moves have been made", context do
      marked_board = context[:empty]
        |> TicTacToe.Board.mark(0, :player_one)
        |> TicTacToe.Board.mark(2, :player_two)
        |> TicTacToe.Board.mark(4, :player_one)
        |> TicTacToe.Board.mark(6, :player_two)
      assert TicTacToe.Game.current_player(marked_board) == :player_one
    end

  end

  describe "making a move in a game of tic-tac-toe" do

    test "makes the first move on an empty board" do
      marked_board = TicTacToe.Game.move(0)
      assert marked_board == %{0 => :player_one}
    end

    test "makes a second move", context do
      marked_board = context[:empty]
        |> TicTacToe.Game.move(1)
        |> TicTacToe.Game.move(2)
      assert marked_board == %{1 => :player_one, 2 => :player_two}
    end

    test "makes a many moves", context do
      expected_board = %{4 => :player_one, 7 => :player_two, 3 => :player_one, 2 => :player_two}
      marked_board = context[:empty]
        |> TicTacToe.Game.move(4)
        |> TicTacToe.Game.move(7)
        |> TicTacToe.Game.move(3)
        |> TicTacToe.Game.move(2)
      assert marked_board == expected_board
    end

  end

end
