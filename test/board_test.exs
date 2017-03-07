defmodule BoardTest do
  use ExUnit.Case
  doctest TicTacToe.Board

  setup do
    {:ok, empty: TicTacToe.Board.empty_board}
  end

  describe "marking a cell on a board" do

    test "it returns an empty board", context do
      assert context[:empty] == %{}
    end

    test "it marks cell 0 on an empty board with :player_one", context do
      marked_board = TicTacToe.Board.mark(:player_one, 0, context[:empty])
      assert marked_board == %{0 => :player_one}
    end

    test "it marks cell 4 on an empty board with :player_two", context do
      marked_board = TicTacToe.Board.mark(:player_two, 4, context[:empty])
      assert marked_board == %{4 => :player_two}
    end

    test "it marks two cells on a board", context do
      marked_board = TicTacToe.Board.mark(:p2, 5, TicTacToe.Board.mark(:p1, 7, context[:empty]))
      assert marked_board == %{7 => :p1, 5 => :p2}
    end

    test "it returns :empty for a cell if the board is empty", context do
      assert :empty == TicTacToe.Board.cell_status(0, context[:empty])
    end

    test "it returns :empty for a cell if it has not yet been marked", context do
      marked_board = TicTacToe.Board.mark(:p1, 3, context[:empty])
      assert :empty == TicTacToe.Board.cell_status(8, marked_board)
    end

    test "it returns :player_one for a cell that has been marked by :player_one", context do
      marked_board = TicTacToe.Board.mark(:player_one, 1, context[:empty])
      assert :player_one == TicTacToe.Board.cell_status(1, marked_board)
    end

    test "it returns :player_two for a cell that has been marked by :player_two", context do
      marked_board = TicTacToe.Board.mark(:player_two, 0, context[:empty])
      assert :player_two == TicTacToe.Board.cell_status(0, marked_board)
    end

  end

end
