defmodule ConsoleMessagesTest do
  use ExUnit.Case
  alias TicTacToe.Board, as: Board
  alias TicTacToe.ConsoleMessages, as: Messages

  describe "a formatted board for the console" do

    test "returns a blank board" do
      output = "   |   |   \n-----------\n   |   |   \n-----------\n   |   |   \n"
      assert Messages.formatted_board(Board.empty_board) == output
    end

    test "returns a board with one mark in the first cell" do
      marked_board = Board.mark(Board.empty_board, 0, :player_one)
      output = " X |   |   \n-----------\n   |   |   \n-----------\n   |   |   \n"
      assert Messages.formatted_board(marked_board) == output
    end

    test "returns a board with two marks" do
      marked_board = Board.empty_board
      |> Board.mark(1, :player_one)
      |> Board.mark(5, :player_two)
      output = "   | X |   \n-----------\n   |   | O \n-----------\n   |   |   \n"
      assert Messages.formatted_board(marked_board) == output
    end

    test "returns a board with three marks" do
      marked_board = Board.empty_board
      |> Board.mark(3, :player_one)
      |> Board.mark(7, :player_two)
      |> Board.mark(2, :player_one)
      output = "   |   | X \n-----------\n X |   |   \n-----------\n   | O |   \n"
      assert Messages.formatted_board(marked_board) == output
    end

    test "returns a filled board" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_two)
      |> Board.mark(5, :player_one)
      |> Board.mark(6, :player_one)
      |> Board.mark(7, :player_two)
      |> Board.mark(8, :player_one)
      output = " X | O | X \n-----------\n X | O | X \n-----------\n X | O | X \n"
      assert Messages.formatted_board(marked_board) == output
    end

  end

end
