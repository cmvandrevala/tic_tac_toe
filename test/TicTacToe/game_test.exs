defmodule GameTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  
  alias TicTacToe.Board, as: Board
  alias TicTacToe.Game, as: Game
  alias TicTacToe.Rules, as: Rules

  describe "the current player" do

    test "is :player_one on an empty board" do
      assert Game.current_player(Board.empty_board) == :player_one
    end

    test "is :player_two if player one has taken a single turn" do
      marked_board = Board.mark(Board.empty_board, 0, :player_one)
      assert Game.current_player(marked_board) == :player_two
    end

    test "is :player_one if four moves have been made" do
      marked_board = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(2, :player_two)
        |> Board.mark(4, :player_one)
        |> Board.mark(6, :player_two)
      assert Game.current_player(marked_board) == :player_one
    end

  end

  describe "making a move in a game of tic-tac-toe" do

    test "makes the first move on an empty board" do
      marked_board = Game.move(0)
      assert marked_board == %{0 => :player_one}
    end

    test "makes a second move" do
      marked_board = Board.empty_board
        |> Game.move(1)
        |> Game.move(2)
      assert marked_board == %{1 => :player_one, 2 => :player_two}
    end

    test "makes a many moves" do
      expected_board = %{4 => :player_one, 7 => :player_two, 3 => :player_one, 2 => :player_two}
      marked_board = Board.empty_board
        |> Game.move(4)
        |> Game.move(7)
        |> Game.move(3)
        |> Game.move(2)
      assert marked_board == expected_board
    end

  end

  describe "playing a game of tic-tac-toe" do

    test "two first available spot computer players play to completion" do
      capture_io fn ->
        played_game = Game.play(&Game.first_available_spot_computer_player/1, &Game.first_available_spot_computer_player/1)
        refute Rules.in_progress?(played_game)
      end
    end

    test "two first available spot computer players play to a winner" do
      capture_io fn ->
        played_game = Game.play(&Game.first_available_spot_computer_player/1, &Game.first_available_spot_computer_player/1)
        assert Rules.status(played_game) == :player_one
      end
    end

  end

end
