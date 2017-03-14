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

    test "sanitizes a message correctly (variation one)" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_one, fn(_) -> "~`8!@#$%^&*()-_+=\n" end)
        assert output == 8
      end
    end

    test "sanitizes a message correctly (variation two)" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_two, fn(_) -> "3{[|]}\\:;\"\'" end)
        assert output == 3
      end
    end

    test "sanitizes a message correctly (variation three)" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, :player_two, fn(_) -> "1,<.>/?" end)
        assert output == 1
      end
    end

  end

end
