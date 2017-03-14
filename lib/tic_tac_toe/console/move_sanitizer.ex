defmodule TicTacToe.Console.MoveSanitizer do

  def sanitize(input), do: Regex.replace(~r/[^0-9]/, input, "")

end
