defmodule BoardTest do
  use ExUnit.Case
  doctest TicTacToe.Board


  setup do
    {:ok, empty: TicTacToe.Board.empty_board}
  end

  describe "marking a cell on a board" do

    test "returns an empty board", context do
      assert context[:empty] == %{}
    end

    test "marks cell 0 on an empty board with :player_one", context do
      marked_board = TicTacToe.Board.mark(context[:empty], 0, :player_one)
      assert marked_board == %{0 => :player_one}
    end

    test "marks cell 4 on an empty board with :player_two", context do
      marked_board = TicTacToe.Board.mark(context[:empty], 4, :player_two)
      assert marked_board == %{4 => :player_two}
    end

    test "marks two cells on a board", context do
      marked_board = context[:empty]
        |> TicTacToe.Board.mark(5, :p2)
        |> TicTacToe.Board.mark(7, :p1)
      assert marked_board == %{7 => :p1, 5 => :p2}
    end

    test "returns :empty for a cell if the board is empty", context do
      assert :empty == TicTacToe.Board.cell_status(context[:empty], 0)
    end

    test "returns :empty for a cell if it has not yet been marked", context do
      marked_board = TicTacToe.Board.mark(context[:empty], 3, :p1)
      assert :empty == TicTacToe.Board.cell_status(marked_board, 8)
    end

    test "returns :player_one for a cell that has been marked by :player_one", context do
      marked_board = TicTacToe.Board.mark(context[:empty], 1, :player_one)
      assert :player_one == TicTacToe.Board.cell_status(marked_board, 1)
    end

    test "returns :player_two for a cell that has been marked by :player_two", context do
      marked_board = TicTacToe.Board.mark(context[:empty], 0, :player_two)
      assert :player_two == TicTacToe.Board.cell_status(marked_board, 0)
    end

  end

  describe "identifying a filled board" do

    test "returns false for an empty board", context do
      refute TicTacToe.Board.filled?(context[:empty])
    end

    test "returns false for a paritally filled board", context do
      marked_board = context[:empty]
        |> TicTacToe.Board.mark(3, :pl2)
        |> TicTacToe.Board.mark(0, :pl1)
        |> TicTacToe.Board.mark(6, :pl2)
      refute TicTacToe.Board.filled?(marked_board)
    end

    test "returns true for a filled board", context do
      filled_board = context[:empty]
        |> TicTacToe.Board.mark(0, :p1)
        |> TicTacToe.Board.mark(1, :p2)
        |> TicTacToe.Board.mark(2, :p1)
        |> TicTacToe.Board.mark(3, :p2)
        |> TicTacToe.Board.mark(4, :p3)
        |> TicTacToe.Board.mark(5, :p4)
        |> TicTacToe.Board.mark(6, :p3)
        |> TicTacToe.Board.mark(7, :p4)
        |> TicTacToe.Board.mark(8, :p5)
      assert TicTacToe.Board.filled?(filled_board)
    end

  end

  describe "identifying an empty board" do

    test "returns true for an empty board", context do
      assert TicTacToe.Board.empty?(context[:empty])
    end

    test "returns false for a paritally filled board", context do
      marked_board = context[:empty]
        |> TicTacToe.Board.mark(3, :player_one)
        |> TicTacToe.Board.mark(0, :player_one)
        |> TicTacToe.Board.mark(6, :player_one)
      refute TicTacToe.Board.empty?(marked_board)
    end

    test "returns false for a filled board", context do
      filled_board = context[:empty]
        |> TicTacToe.Board.mark(0, :p1)
        |> TicTacToe.Board.mark(1, :p2)
        |> TicTacToe.Board.mark(2, :p1)
        |> TicTacToe.Board.mark(3, :p2)
        |> TicTacToe.Board.mark(4, :p3)
        |> TicTacToe.Board.mark(5, :p4)
        |> TicTacToe.Board.mark(6, :p3)
        |> TicTacToe.Board.mark(7, :p4)
        |> TicTacToe.Board.mark(8, :p5)
      refute TicTacToe.Board.empty?(filled_board)
    end

  end

  describe "number of filled cells" do

    test "returns 0 for an empty board", context do
      assert TicTacToe.Board.number_of_filled_cells(context[:empty]) == 0
    end

    test "returns 1 for one filled cell", context do
      marked_board = TicTacToe.Board.mark(context[:empty], 3, :player_one)
      assert TicTacToe.Board.number_of_filled_cells(marked_board) == 1
    end

  end

end
