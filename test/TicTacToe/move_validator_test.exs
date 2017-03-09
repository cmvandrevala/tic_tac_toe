defmodule MoveValidatorTest do
  use ExUnit.Case

  alias TicTacToe.Board, as: Board
  alias TicTacToe.MoveValidator, as: Validator

  setup _context do
    board = Board.empty_board
    |> Board.current_marks
    |> List.to_tuple
    [board: board]
  end

  describe "validating raw input from the user" do

    test "detects if an input has a decimal point" do
      assert Validator.contains_decimal?("4.5")
      refute Validator.contains_decimal?("37")
      refute Validator.contains_decimal?("abc")
    end

    test "detects if an input contains a non-numeric character" do
      assert Validator.contains_letter?("abc")
      assert Validator.contains_letter?("a1b2c3")
      refute Validator.contains_letter?("37")
      refute Validator.contains_letter?("-44.8")
    end

    test "detects if it is simply a newline character" do
      assert Validator.only_newline?("\n")
      refute Validator.only_newline?("abc123")
      refute Validator.only_newline?("wxyz\n")
    end

  end

  describe "validating a cell after the raw input filter" do

    test "returns :valid for a valid move", context do
      assert Validator.validate_cell(0, context[:board]) == :valid
      assert Validator.validate_cell(1, context[:board]) == :valid
      assert Validator.validate_cell(2, context[:board]) == :valid
      assert Validator.validate_cell(3, context[:board]) == :valid
      assert Validator.validate_cell(4, context[:board]) == :valid
      assert Validator.validate_cell(5, context[:board]) == :valid
      assert Validator.validate_cell(6, context[:board]) == :valid
      assert Validator.validate_cell(7, context[:board]) == :valid
      assert Validator.validate_cell(8, context[:board]) == :valid
    end

    test "returns :not_an_integer when the input is nil", context do
      assert Validator.validate_cell(nil, context[:board]) == :not_an_integer
    end

    test "returns :integer_too_small for an input that is too small", context do
      assert Validator.validate_cell(-10, context[:board]) == :too_small
    end

    test "returns :integer_too_small for an input that is too small (near boundary)", context do
      assert Validator.validate_cell(-1, context[:board]) == :too_small
    end

    test "returns :integer_too_large for an input that is too large", context do
      assert Validator.validate_cell(98, context[:board]) == :too_large
    end

    test "returns :integer_too_large for an input that is too large (near boundary)", context do
      assert Validator.validate_cell(9, context[:board]) == :too_large
    end

    test "returns :cell_taken if a cell has already been taken" do
      board = Board.mark(Board.empty_board, 0, :player_one)
      marks = List.to_tuple(Board.current_marks(board))
      assert Validator.validate_cell(0, marks) == :cell_taken
    end

  end

end
