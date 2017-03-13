defmodule TicTacToe.Console.MainMenu do
  alias TicTacToe.Core.Game, as: Game

  def start, do: start(&tic_tac_toe_setup/0,
                       &tic_tac_toe_play/2,
                       &tic_tac_toe_teardown/3)

  def start(setup, play, teardown) do
    {player_one, player_two} = setup.()
    play.(player_one, player_two)
    teardown.(setup, play, teardown)
  end

  def tic_tac_toe_setup do
    IO.puts ""
    IO.puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    IO.puts "| Welcome to Elixir Tic-Tac-Toe! |"
    IO.puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    IO.puts ""
    IO.puts "Please select the first player."
    player_one = select_player()
    IO.puts ""
    IO.puts "Please select the second player."
    player_two = select_player()
    {player_one, player_two}
  end

  def tic_tac_toe_play(player_one, player_two) do
    IO.puts ""
    IO.puts "The game will start now!"
    Game.play(player_one, player_two)
  end

  def tic_tac_toe_teardown(setup, play, teardown) do
    if play_again?() do
      start(setup, play, teardown)
    else
      IO.puts ""
      IO.puts "Goodbye! Thanks for playing!"
    end
  end

  defp select_player do
    IO.puts ""
    IO.puts "The player types are:"
    IO.puts "(1) Human"
    IO.puts "(2) Easy Computer"
    IO.puts "(3) Hard Computer"
    IO.puts ""
    answer = IO.gets "Which type of player would you like (1, 2, or 3)? "
    case answer do
      "1\n" -> &Game.human_player/2
      "2\n" -> &Game.first_available_spot_computer_player/2
      "3\n" -> &Game.unbeatable_computer_player/2
      _ ->
        IO.puts "That is not a valid input!"
        select_player()
    end

  end

  defp play_again? do
    IO.puts ""
    answer = IO.gets "Would you like to play again? Yes (Y) or No (N): "
    case answer do
      "Y\n" -> true
      "Yes\n" -> true
      "y\n" -> true
      "yes\n" -> true
      "N\n" -> false
      "n\n" -> false
      "No\n" -> false
      "no\n" -> false
      _ ->
        IO.puts ""
        IO.puts "That is not a valid response."
        play_again?()
    end
  end

end
