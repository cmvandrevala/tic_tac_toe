defmodule TicTacToe do
  alias TicTacToe.Core.Game, as: Game

  def main(args) do
    Game.play(&Game.human_player/1, &Game.human_player/1)
  end

end
