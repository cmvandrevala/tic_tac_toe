defmodule BoardTest do
  use ExUnit.Case
  alias TicTacToe.Board, as: Board

  describe "marking a cell on a board" do

    test "returns an empty board" do
      assert Board.empty_board == %{}
    end

    test "marks cell 0 on an empty board with :player_one" do
      marked_board = Board.mark(Board.empty_board, 0, :player_one)
      assert marked_board == %{0 => :player_one}
    end

    test "marks cell 4 on an empty board with :player_two" do
      marked_board = Board.mark(Board.empty_board, 4, :player_two)
      assert marked_board == %{4 => :player_two}
    end

    test "marks two cells on a board" do
      marked_board = Board.empty_board
        |> Board.mark(5, :p2)
        |> Board.mark(7, :p1)
      assert marked_board == %{7 => :p1, 5 => :p2}
    end

    test "returns :empty for a cell if the board is empty" do
      assert :empty == Board.cell_status(Board.empty_board, 0)
    end

    test "returns :empty for a cell if it has not yet been marked" do
      marked_board = Board.mark(Board.empty_board, 3, :p1)
      assert :empty == Board.cell_status(marked_board, 8)
    end

    test "returns :player_one for a cell that has been marked by :player_one" do
      marked_board = Board.mark(Board.empty_board, 1, :player_one)
      assert :player_one == Board.cell_status(marked_board, 1)
    end

    test "returns :player_two for a cell that has been marked by :player_two" do
      marked_board = Board.mark(Board.empty_board, 0, :player_two)
      assert :player_two == Board.cell_status(marked_board, 0)
    end

  end

  describe "identifying a filled board" do

    test "returns false for an empty board" do
      refute Board.filled?(Board.empty_board)
    end

    test "returns false for a paritally filled board" do
      marked_board = Board.empty_board
        |> Board.mark(3, :pl2)
        |> Board.mark(0, :pl1)
        |> Board.mark(6, :pl2)
      refute Board.filled?(marked_board)
    end

    test "returns true for a filled board" do
      filled_board = Board.empty_board
        |> Board.mark(0, :p1)
        |> Board.mark(1, :p2)
        |> Board.mark(2, :p1)
        |> Board.mark(3, :p2)
        |> Board.mark(4, :p3)
        |> Board.mark(5, :p4)
        |> Board.mark(6, :p3)
        |> Board.mark(7, :p4)
        |> Board.mark(8, :p5)
      assert Board.filled?(filled_board)
    end

  end

  describe "identifying an empty board" do

    test "returns true for an empty board" do
      assert Board.empty?(Board.empty_board)
    end

    test "returns false for a paritally filled board" do
      marked_board = Board.empty_board
        |> Board.mark(3, :player_one)
        |> Board.mark(0, :player_one)
        |> Board.mark(6, :player_one)
      refute Board.empty?(marked_board)
    end

    test "returns false for a filled board" do
      filled_board = Board.empty_board
        |> Board.mark(0, :p1)
        |> Board.mark(1, :p2)
        |> Board.mark(2, :p1)
        |> Board.mark(3, :p2)
        |> Board.mark(4, :p3)
        |> Board.mark(5, :p4)
        |> Board.mark(6, :p3)
        |> Board.mark(7, :p4)
        |> Board.mark(8, :p5)
      refute Board.empty?(filled_board)
    end

  end

  describe "number of filled cells" do

    test "returns 0 for an empty board" do
      assert Board.number_of_filled_cells(Board.empty_board) == 0
    end

    test "returns 1 for one filled cell" do
      marked_board = Board.mark(Board.empty_board, 3, :player_one)
      assert Board.number_of_filled_cells(marked_board) == 1
    end

  end

end
