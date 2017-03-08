defmodule TicTacToe.Game do
  alias TicTacToe.Board, as: Board
  alias TicTacToe.ConsoleMessages, as: Messages
  alias TicTacToe.Rules, as: Rules

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
    IO.puts Messages.formatted_board(board)
    if Rules.in_progress?(board) do
      take_turn(player_one, player_two, board)
    else
      board
    end
  end

  defp take_turn(player_one, player_two, board) do
    case current_player(board) do
      :player_one -> play(player_one, player_two, player_one.(board))
      :player_two -> play(player_one, player_two, player_two.(board))
    end
  end

  def human_player(board) do
    cell = IO.gets "Enter your move: "
    move(board, elem(Integer.parse(cell), 0))
  end

  def first_available_spot_computer_player(board) do
    cell = TicTacToe.ComputerPlayer.first_available_spot(board)
    move(board, cell)
  end

end
