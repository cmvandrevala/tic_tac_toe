defmodule TicTacToe.Console.MainMenu do
  alias TicTacToe.Core.Game, as: Game
  alias TicTacToe.Console.ConsoleMessages, as: Messages

  def start, do: start(&tic_tac_toe_setup/0,
                       &tic_tac_toe_play/2,
                       &tic_tac_toe_teardown/3)

  def start(setup, play, teardown) do
    {player_one, player_two} = setup.()
    play.(player_one, player_two)
    teardown.(setup, play, teardown)
  end

  def tic_tac_toe_setup do
    IO.puts Messages.menu_welcome
    IO.puts Messages.select_player_one
    player_one = select_player()
    IO.puts Messages.select_player_two
    player_two = select_player()
    {player_one, player_two}
  end

  def tic_tac_toe_play(player_one, player_two) do
    IO.puts Messages.game_begins_now
    Game.play(player_one, player_two)
  end

  def tic_tac_toe_teardown(setup, play, teardown) do
    if play_again?() do
      start(setup, play, teardown)
    else
      IO.puts Messages.menu_quit
    end
  end

  defp select_player do
    case IO.gets Messages.player_type_prompt do
      "1\n" -> &Game.human_player/2
      "2\n" -> &Game.first_available_spot_computer_player/2
      "3\n" -> &Game.unbeatable_computer_player/2
      _ ->
        IO.puts Messages.invalid_menu_input
        select_player()
    end

  end

  defp play_again? do
    answer = IO.gets Messages.play_again_prompt
    cond do
      Enum.member?(affirmative_answers(), answer) -> true
      Enum.member?(negative_answers(), answer) -> false
      true ->
        IO.puts Messages.invalid_menu_input
        play_again?()
    end
  end

  defp affirmative_answers do
    ["Y\n", "Yes\n", "y\n", "yes\n"]
  end

  defp negative_answers do
    ["N\n", "No\n", "n\n", "no\n"]
  end

end
