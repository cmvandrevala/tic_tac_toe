defmodule BoardTest do
  use ExUnit.Case
  alias TicTacToe.Core.Board, as: Board

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

  describe "number of filled cells" do

    test "returns 0 for an empty board" do
      assert Board.number_of_filled_cells(Board.empty_board) == 0
    end

    test "returns 1 for one filled cell" do
      marked_board = Board.mark(Board.empty_board, 3, :player_one)
      assert Board.number_of_filled_cells(marked_board) == 1
    end

    test "returns 3 for three filled cells" do
      marked_board = Board.empty_board
        |> Board.mark(3, :player_one)
        |> Board.mark(5, :player_two)
        |> Board.mark(7, :player_one)
      assert Board.number_of_filled_cells(marked_board) == 3
    end

  end

  describe "the current cell values" do

    test "returns all empty cells if no moves have been made" do
      expected_output = [:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty]
      assert Board.current_marks(Board.empty_board) == expected_output
    end

    test "returns the correct values after one mark" do
      marked_board = Board.mark(Board.empty_board, 2, :player_one)
      expected_output = [:empty, :empty, :player_one, :empty, :empty, :empty, :empty, :empty, :empty]
      assert Board.current_marks(marked_board) == expected_output
    end

    test "returns the correct values after two marks" do
      marked_board = Board.empty_board
        |> Board.mark(5, :player_one)
        |> Board.mark(7, :player_two)
      expected_output = [:empty, :empty, :empty, :empty, :empty, :player_one, :empty, :player_two, :empty]
      assert Board.current_marks(marked_board) == expected_output
    end

    test "returns the correct values after many marks" do
      marked_board = Board.empty_board
        |> Board.mark(5, :player_one)
        |> Board.mark(7, :player_two)
        |> Board.mark(0, :player_one)
        |> Board.mark(8, :player_two)
      expected_output = [:player_one, :empty, :empty, :empty, :empty, :player_one, :empty, :player_two, :player_two]
      assert Board.current_marks(marked_board) == expected_output
    end

  end

  describe "the total number of cells on the board" do

    test "returns nine for a standard tic-tac-toe board" do
      assert Board.number_of_cells == 9
    end

  end

  describe "remaining spaces on the board" do

    test "returns all of the spaces for an empty board" do
      assert Board.remaining_spaces(Board.empty_board) == [0, 1, 2, 3, 4, 5, 6, 7, 8]
    end

    test "returns the remaining spaces for a board with one mark" do
      marked_board = Board.mark(Board.empty_board, 5, :player_one)
      assert Board.remaining_spaces(marked_board) == [0, 1, 2, 3, 4, 6, 7, 8]
    end

    test "returns the remaining spaces for a board with one mark (different cell)" do
      marked_board = Board.mark(Board.empty_board, 2, :player_one)
      assert Board.remaining_spaces(marked_board) == [0, 1, 3, 4, 5, 6, 7, 8]
    end

    test "returns the remaining spaces for a board with two marks" do
      marked_board = Board.empty_board
      |> Board.mark(6, :player_one)
      |> Board.mark(7, :player_two)
      assert Board.remaining_spaces(marked_board) == [0, 1, 2, 3, 4, 5, 8]
    end

    test "returns the remaining spaces for a board with three marks" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(5, :player_two)
      |> Board.mark(8, :player_one)
      assert Board.remaining_spaces(marked_board) == [1, 2, 3, 4, 6, 7]
    end

    test "returns the remaining spaces for a board with many marks" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_two)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      |> Board.mark(7, :player_one)
      assert Board.remaining_spaces(marked_board) == [8]
    end

    test "returns no spaces for a full board" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_one)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_one)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_one)
      assert Board.remaining_spaces(marked_board) == []
    end

  end

  describe "check if the board is empty" do

    test "returns true for an empty board" do
      assert Board.empty?(Board.empty_board)
    end

    test "returns false for a non-empty board" do
      board = Board.mark(Board.empty_board, 3, :player_one)
      refute Board.empty?(board)
    end

  end

  describe "check if the board is filled" do

    test "returns false for an empty board" do
      refute Board.filled?(Board.empty_board)
    end

    test "returns false for a partially-filled board" do
      board = Board.mark(Board.empty_board, 3, :player_one)
      refute Board.filled?(board)
    end

    test "returns true for a filled board" do
      board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_one)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_one)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_one)
      assert Board.filled?(board)
    end

  end

end
