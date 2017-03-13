defmodule TicTacToe do
  alias TicTacToe.Core.Game, as: Game

  def main(_) do
    Game.play(&Game.human_player/2, &Game.unbeatable_computer_player/2)
  end

end
