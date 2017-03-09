defmodule HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias TicTacToe.Board, as: Board
  alias TicTacToe.HumanPlayer, as: HumanPlayer

  describe "a human player's move" do

    test "returns the integer 5 when the user enters 5 at the console" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, fn(_) -> "5\n" end)
        assert output == 5
      end
    end

    test "returns the integer 8 when the user enters 8 at the console" do
      capture_io fn ->
        output = HumanPlayer.get_move(Board.empty_board, fn(_) -> "8\n" end)
        assert output == 8
      end
    end

  end

end
