defmodule MoveSanitizerTest do
  use ExUnit.Case

  alias TicTacToe.Console.MoveSanitizer, as: Sanitizer

  describe "sanitizing the input" do

    test "handles an empty string" do
      assert Sanitizer.sanitize("") == ""
    end

    test "sanitizes a single newline character" do
      assert Sanitizer.sanitize("\n") == ""
    end

    test "sanitizes a valid input" do
      assert Sanitizer.sanitize("2\n") == "2"
    end

    test "sanitizes an input with no newline character" do
      assert Sanitizer.sanitize("7") == "7"
    end

    test "sanitizes single quotes" do
      assert Sanitizer.sanitize("'8\n") == "8"
    end

    test "sanitizes double quotes" do
      assert Sanitizer.sanitize("\"13\"\n") == "13"
    end

    test "sanitizes semicolons" do
      assert Sanitizer.sanitize(";2;\n") == "2"
    end

    test "sanitizes colons" do
      assert Sanitizer.sanitize(":7:\n") == "7"
    end

    test "sanitizes commas" do
      assert Sanitizer.sanitize(",,6\n") == "6"
    end

    test "sanitizes back ticks" do
      assert Sanitizer.sanitize("`6`\n") == "6"
    end

    test "sanitizes a complicated string" do
      assert Sanitizer.sanitize("\"4,3,/~`\"\n") == "43"
    end

  end


end
