defmodule HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.Console.HumanPlayer, as: HumanPlayer

  describe "a human player's move" do

    test "returns the integer 5 when the user enters 5 at the console" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_one, fn(_) -> "5\n" end)
        assert output == 5
      end
    end

    test "returns the integer 8 when the user enters 8 at the console" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_two, fn(_) -> "8\n" end)
        assert output == 8
      end
    end

    test "filters out single quotes" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_one, fn(_) -> "'8\n" end)
        assert output == 8
      end
    end

    test "filters out double quotes" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_two, fn(_) -> "\"8\"\n" end)
        assert output == 8
      end
    end

    test "filters out semicolons" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_one, fn(_) -> "2;\n" end)
        assert output == 2
      end
    end

    test "filters out colons" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_two, fn(_) -> ":7:\n" end)
        assert output == 7
      end
    end

    test "filters out commas" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_one, fn(_) -> ",,6\n" end)
        assert output == 6
      end
    end

  end

end
