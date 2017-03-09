defmodule RulesTest do
  use ExUnit.Case
  alias TicTacToe.Board, as: Board
  alias TicTacToe.Rules, as: Rules

  describe "if a game is in progress" do

    test "returns true if the board is empty" do
      assert Rules.in_progress?(Board.empty_board)
    end

    test "returns true if the board contains moves with no wins or ties" do
      marked_board = Board.empty_board
        |> Board.mark(2, :player_one)
        |> Board.mark(5, :player_two)
        |> Board.mark(6, :player_one)
      assert Rules.in_progress? marked_board
    end

    test "returns false if player one has won in the top row" do
      marked_board = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_one)
        |> Board.mark(2, :player_one)
      refute Rules.in_progress? marked_board
    end

    test "returns false if player two has won in the middle row" do
      marked_board = Board.empty_board
        |> Board.mark(3, :player_two)
        |> Board.mark(4, :player_two)
        |> Board.mark(5, :player_two)
      refute Rules.in_progress? marked_board
    end

    test "returns false if player one has won in the bottom row" do
      marked_board = Board.empty_board
        |> Board.mark(6, :player_one)
        |> Board.mark(7, :player_one)
        |> Board.mark(8, :player_one)
      refute Rules.in_progress? marked_board
    end

    test "returns false if player one has won in the left column" do
      marked_board = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(3, :player_one)
        |> Board.mark(6, :player_one)
      refute Rules.in_progress? marked_board
    end

    test "returns false if player two has won in the center column" do
      marked_board = Board.empty_board
        |> Board.mark(1, :player_two)
        |> Board.mark(4, :player_two)
        |> Board.mark(7, :player_two)
      refute Rules.in_progress? marked_board
    end

    test "returns false if player two has won in the right column" do
      marked_board = Board.empty_board
        |> Board.mark(2, :player_two)
        |> Board.mark(5, :player_two)
        |> Board.mark(8, :player_two)
      refute Rules.in_progress? marked_board
    end

    test "returns false if player two has won in the first diagonal" do
      marked_board = Board.empty_board
        |> Board.mark(0, :player_two)
        |> Board.mark(4, :player_two)
        |> Board.mark(8, :player_two)
      refute Rules.in_progress? marked_board
    end

    test "returns false if player one has won in the first diagonal" do
      marked_board = Board.empty_board
        |> Board.mark(2, :player_one)
        |> Board.mark(4, :player_one)
        |> Board.mark(6, :player_one)
      refute Rules.in_progress? marked_board
    end

    test "returns false if the game has ended in a tie" do
      marked_board = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_two)
        |> Board.mark(2, :player_one)
        |> Board.mark(4, :player_two)
        |> Board.mark(3, :player_one)
        |> Board.mark(5, :player_two)
        |> Board.mark(7, :player_one)
        |> Board.mark(6, :player_two)
        |> Board.mark(8, :player_one)
      refute Rules.in_progress?(marked_board)
    end

  end

  describe "the status of the game" do

    test "returns :in_progress on an empty board" do
      assert Rules.status(Board.empty_board) == :in_progress
    end

    test "returns :in_progress there are no wins or ties" do
      marked_board = Board.empty_board
        |> Board.mark(8, :player_one)
        |> Board.mark(7, :player_two)
        |> Board.mark(6, :player_one)
        |> Board.mark(0, :player_two)
      assert Rules.status(marked_board) == :in_progress
    end

    test "returns :player_one if the first player has won the game" do
      marked_board = Board.empty_board
        |> Board.mark(8, :player_one)
        |> Board.mark(5, :player_one)
        |> Board.mark(2, :player_one)
      assert Rules.status(marked_board) == :player_one
    end

    test "returns :player_two if the second player has won the game" do
      marked_board = Board.empty_board
        |> Board.mark(7, :player_two)
        |> Board.mark(4, :player_two)
        |> Board.mark(1, :player_two)
      assert Rules.status(marked_board) == :player_two
    end

    test "returns :tie if the game has ended in a tie" do
      marked_board = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_two)
        |> Board.mark(2, :player_one)
        |> Board.mark(4, :player_two)
        |> Board.mark(3, :player_one)
        |> Board.mark(5, :player_two)
        |> Board.mark(7, :player_one)
        |> Board.mark(6, :player_two)
        |> Board.mark(8, :player_one)
      assert Rules.status(marked_board) == :tie
    end

  end

end
