defmodule TreeCreator do
  alias TicTacToe.Core.Rules

  def utility(board, player) do
    board_status = Rules.status(board)
    cond do
        board_status == :in_progress -> nil
        board_status == player -> 10
        board_status == :tie -> 0
        true -> -10
    end
  end

  def create(board) do
    
    %TreeNode{value: 0}
  end
end