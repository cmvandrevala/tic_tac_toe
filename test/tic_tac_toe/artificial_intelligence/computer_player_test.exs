defmodule ComputerPlayerTest do
  use ExUnit.Case
  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.ArtificialIntelligence.ComputerPlayer, as: Player

  describe "a first available spot computer player" do

    test "returns the first cell (index 0) if the board is empty" do
      assert Player.first_available_spot(Board.empty_board) == 0
    end

    test "returns the first cell (index 0) if it is available" do
      marked_board = Board.mark(Board.empty_board, 5, :p1)
      assert Player.first_available_spot(marked_board) == 0
    end

    test "returns the second cell (index 1) if it is available" do
      marked_board = Board.mark(Board.empty_board, 0, :player)
      assert Player.first_available_spot(marked_board) == 1
    end

    test "returns the third cell (index 2) if it is available" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player1)
      |> Board.mark(1, :player2)
      assert Player.first_available_spot(marked_board) == 2
    end

    test "returns the fourth cell (index 3) if it is available" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player1)
      |> Board.mark(1, :player2)
      |> Board.mark(8, :player1)
      |> Board.mark(2, :player2)
      assert Player.first_available_spot(marked_board) == 3
    end

  end

  describe "the utility measurement of a given board status" do

    test "returns 10 if the selected player wins (player one)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_one)
      |> Board.mark(2, :player_one)
      assert Player.utility(marked_board, :player_one) == 10
    end

    test "returns 10 if the selected player wins (player two)" do
      marked_board = Board.empty_board
      |> Board.mark(2, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(6, :player_two)
      assert Player.utility(marked_board, :player_two) == 10
    end

    test "returns -10 if the selected player loses (player one)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(8, :player_two)
      assert Player.utility(marked_board, :player_one) == -10
    end

    test "returns -10 if the selected player loses (player two)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(4, :player_one)
      |> Board.mark(8, :player_one)
      assert Player.utility(marked_board, :player_two) == -10
    end

    test "returns 0 if the game is a tie (player one)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      assert Player.utility(marked_board, :player_one) == 0
    end

    test "returns 0 if the game is a tie (player two)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      assert Player.utility(marked_board, :player_two) == 0
    end

    test "returns nil for a game in progress" do
      assert Player.utility(Board.empty_board, :player_one) == nil
    end

  end

  describe "an unbeatable computer player" do

    test "returns the first cell if it is the first move of the game" do
      assert Player.best_spot(Board.empty_board) == 0
    end

    test "returns the center cell if it is the second move of the game and its available" do
      marked_board = Board.mark(Board.empty_board, 1, :player_one)
      assert Player.best_spot(marked_board) == 4
    end

    test "returns the first cell if it is the second move of the game and center is not available" do
      marked_board = Board.mark(Board.empty_board, 4, :player_one)
      assert Player.best_spot(marked_board) == 0
    end

  end

end
