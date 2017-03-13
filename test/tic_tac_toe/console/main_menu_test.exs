defmodule MainMenuTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias TicTacToe.Console.MainMenu, as: Menu

  defp fake_setup do
    IO.puts "Fake setup was called"
    {:foo, :bar}
  end

  defp fake_play(_, _), do: IO.puts "Fake play was called"

  defp fake_teardown(_, _, _), do: IO.puts "Fake teardown was called"

  describe "the main menu" do

    test "calls the setup, play, and teardown functions" do
      output = capture_io fn ->
        Menu.start(&fake_setup/0, &fake_play/2, &fake_teardown/3)
      end
      assert String.contains?(output, "Fake setup was called")
      assert String.contains?(output, "Fake play was called")
      assert String.contains?(output, "Fake teardown was called")
    end

  end

end
