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

end
