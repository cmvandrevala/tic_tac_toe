defmodule GameTreeTest do
  use ExUnit.Case

  alias TicTacToe.ArtificialIntelligence.GameTree, as: Tree

  describe "constructing a game tree for minimax" do

    test "returns a node with a value of 10" do
      node = Tree.node(10)
      assert node.value == 10
    end

    test "returns a node with a value of nil" do
      node = Tree.node
      assert node.value == nil
    end

    test "adds one node as a child" do
      tree = Tree.node(1) |> Tree.add_child(Tree.node(2))
      assert tree.children == [Tree.node(2)]
    end

    test "adds two nodes as children to one parent" do
      tree = Tree.node(1)
      |> Tree.add_child(Tree.node(2))
      |> Tree.add_child(Tree.node(3))
      assert tree.children == [Tree.node(2), Tree.node(3)]
    end

    test "adds many nodes as children to one parent" do
      output = [Tree.node(8), Tree.node(4), Tree.node(4), Tree.node(6), Tree.node(1)]
      tree = Tree.node(1)
      |> Tree.add_child(Tree.node(8))
      |> Tree.add_child(Tree.node(4))
      |> Tree.add_child(Tree.node(4))
      |> Tree.add_child(Tree.node(6))
      |> Tree.add_child(Tree.node(1))
      assert tree.children == output
    end

    test "links many nodes together in a chain" do
      middle_node = Tree.add_child(Tree.node(7), Tree.node(4.6))
      root_node = Tree.add_child(Tree.node(1.1), middle_node)
      assert root_node.children == [Tree.add_child(Tree.node(7), Tree.node(4.6))]
    end

  end

end
