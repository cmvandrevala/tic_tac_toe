defmodule TicTacToe.ArtificialIntelligence.GameTree do
  require Integer
  alias TicTacToe.ArtificialIntelligence.Node, as: Node

  def node, do: %Node{}
  def node(value), do: %Node{value: value}

  def add_child(parent, child),
    do: %Node{value: parent.value, children: parent.children ++ [child]}

  def score(node), do: score(node, 0)
  def score(node, level) do
    cond do
      is_nil(node.value) && Integer.is_even(level) ->
        Enum.max(Enum.map(node.children, &score(&1, level + 1)))
      is_nil(node.value) && Integer.is_odd(level) ->
        Enum.min(Enum.map(node.children, &score(&1, level + 1)))
      true -> node.value
    end
  end

end
