defmodule TicTacToe.Core.Game do
  alias TicTacToe.ArtificialIntelligence.ComputerPlayer, as: ComputerPlayer
  alias TicTacToe.Console.HumanPlayer, as: HumanPlayer
  alias TicTacToe.Console.ConsoleMessages, as: Messages
  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.Core.Rules, as: Rules

  def current_player(board),
    do: if new_round?(board), do: :player_one, else: :player_two

  defp new_round?(board),
    do: rem(Board.number_of_filled_cells(board), 2) == 0

  def move(cell),
    do: move(Board.empty_board, cell)
  def move(board, cell),
    do: Board.mark(board, cell, current_player(board))

  def play(player_one, player_two),
    do: play(player_one, player_two, Board.empty_board)

  def play(player_one, player_two, board) do
    start_game(board)
    if Rules.in_progress?(board) do
      take_turn(player_one, player_two, board)
    else
      end_game(board)
    end
  end

  defp start_game(board) do
    IO.puts "\n#{Messages.formatted_board(board)}"
  end

  defp take_turn(player_one, player_two, board) do
    case current_player(board) do
      :player_one ->
        IO.puts Messages.player_one_turn
        play(player_one, player_two, player_one.(board))
      :player_two ->
        IO.puts Messages.player_two_turn
        play(player_one, player_two, player_two.(board))
    end
  end

  defp end_game(board) do
    IO.puts Messages.game_over
    IO.puts Messages.game_status(Rules.status(board))
    board
  end

  def human_player(board),
    do: move(board, HumanPlayer.get_move(board))

  def first_available_spot_computer_player(board),
    do: move(board, ComputerPlayer.first_available_spot(board))

  def unbeatable_computer_player(board),
    do: move(board, ComputerPlayer.best_spot(board))

end
