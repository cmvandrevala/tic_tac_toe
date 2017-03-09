defmodule TicTacToe.ArtificialIntelligence.GameTree do
  alias TicTacToe.ArtificialIntelligence.Node, as: Node

  def node, do: %Node{}
  def node(value), do: %Node{value: value}

  def add_child(parent, child) do
    %Node{value: parent.value, children: parent.children ++ [child]}
  end

end
