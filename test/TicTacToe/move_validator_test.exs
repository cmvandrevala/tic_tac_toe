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

  describe "validating a move" do

    test "returns :valid for a valid move", context do
      assert Validator.validate(0, context[:board]) == :valid
      assert Validator.validate(1, context[:board]) == :valid
      assert Validator.validate(2, context[:board]) == :valid
      assert Validator.validate(3, context[:board]) == :valid
      assert Validator.validate(4, context[:board]) == :valid
      assert Validator.validate(5, context[:board]) == :valid
      assert Validator.validate(6, context[:board]) == :valid
      assert Validator.validate(7, context[:board]) == :valid
      assert Validator.validate(8, context[:board]) == :valid
    end

    test "returns :is_nil for an input that is nil", context do
      assert Validator.validate(nil, context[:board]) == :is_nil
    end

    test "returns :is_string for an empty string", context do
      assert Validator.validate("", context[:board]) == :is_string
    end

    test "returns :is_string for a non-empty string", context do
      assert Validator.validate("foobar", context[:board]) == :is_string
    end

    test "returns :is_float for an input that is a float", context do
      assert Validator.validate(4.72, context[:board]) == :is_float
    end

    test "returns :integer_too_small for an input that is too small", context do
      assert Validator.validate(-10, context[:board]) == :too_small
    end

    test "returns :integer_too_small for an input that is too small (near boundary)", context do
      assert Validator.validate(-1, context[:board]) == :too_small
    end

    test "returns :integer_too_large for an input that is too large", context do
      assert Validator.validate(98, context[:board]) == :too_large
    end

    test "returns :integer_too_large for an input that is too large (near boundary)", context do
      assert Validator.validate(9, context[:board]) == :too_large
    end

    test "returns :cell_taken if a cell has already been taken" do
      board = Board.mark(Board.empty_board, 0, :player_one)
      marks = List.to_tuple(Board.current_marks(board))
      assert Validator.validate(0, marks) == :cell_taken
    end

  end

end
