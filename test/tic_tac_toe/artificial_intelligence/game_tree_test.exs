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

    test "returns a node with a cell of 2" do
      node = Tree.node(1, 2)
      assert node.cell == 2
    end

    test "returns a node with a cell of nil" do
      node = Tree.node
      assert node.cell == nil
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

  describe "scoring a game tree" do

    test "returns the value of a node if it has no children" do
      assert Tree.score(Tree.node(51)) == 51
    end

    test "returns the value of a node, even if the value is negative" do
      assert Tree.score(Tree.node(-2)) == -2
    end

    test "returns the value of the child of a node if the node has nil value" do
      node = Tree.add_child(Tree.node, Tree.node(8))
      assert Tree.score(node) == 8
    end

    test "returns the maximum of the values of its children (max first)" do
      tree = Tree.node
      |> Tree.add_child(Tree.node(5))
      |> Tree.add_child(Tree.node(1))
      |> Tree.add_child(Tree.node(-3))
      assert Tree.score(tree) == 5
    end

    test "returns the maximum of the values of its children (max last)" do
      tree = Tree.node
      |> Tree.add_child(Tree.node(5))
      |> Tree.add_child(Tree.node(1))
      |> Tree.add_child(Tree.node(38))
      assert Tree.score(tree) == 38
    end

    test "returns the maximum of the values of its children (negative values)" do
      tree = Tree.node
      |> Tree.add_child(Tree.node(-15))
      |> Tree.add_child(Tree.node(-212))
      |> Tree.add_child(Tree.node(-38))
      assert Tree.score(tree) == -15
    end

    test "returns the maximum of the values of its children (duplicate values)" do
      tree = Tree.node
      |> Tree.add_child(Tree.node(1))
      |> Tree.add_child(Tree.node(1))
      |> Tree.add_child(Tree.node(1))
      assert Tree.score(tree) == 1
    end

    test "returns the value of a single grandchild if it is the only node with a value" do
      middle_node = Tree.add_child(Tree.node, Tree.node(14))
      tree = Tree.add_child(Tree.node, middle_node)
      assert Tree.score(tree) == 14
    end

    test "returns the minimum value of all the grandchildren" do
      middle_node = Tree.node
      |> Tree.add_child(Tree.node(124))
      |> Tree.add_child(Tree.node(12))
      |> Tree.add_child(Tree.node(6))
      tree = Tree.add_child(Tree.node, middle_node)
      assert Tree.score(tree) == 6
    end

    test "it returns the score from a child if it is better than a grandchild" do
      child1 = Tree.node
      |> Tree.add_child(Tree.node(12))
      |> Tree.add_child(Tree.node(12))
      |> Tree.add_child(Tree.node(6))
      child2 = Tree.node(8)
      tree = Tree.node
      |> Tree.add_child(child1)
      |> Tree.add_child(child2)
      assert Tree.score(tree) == 8
    end

    test "it correctly traverses two sets of grandchildren" do
      child1 = Tree.node
      |> Tree.add_child(Tree.node(0))
      |> Tree.add_child(Tree.node(-12))
      |> Tree.add_child(Tree.node(60))
      child2 = Tree.node
      |> Tree.add_child(Tree.node(2))
      |> Tree.add_child(Tree.node(25))
      |> Tree.add_child(Tree.node(-6))
      tree = Tree.node
      |> Tree.add_child(child1)
      |> Tree.add_child(child2)
      assert Tree.score(tree) == -6
    end

    test "returns the score for a complicated game tree" do
      d1 = Tree.node(2)
      d2 = Tree.node(-1)
      d3 = Tree.node(3)
      d4 = Tree.node(6)
      d5 = Tree.node(0)
      d6 = Tree.node(0)
      d7 = Tree.node(4)
      d8 = Tree.node(3)

      c1 = Tree.node
      |> Tree.add_child(d1)
      |> Tree.add_child(d2)
      c2 = Tree.node
      |> Tree.add_child(d3)
      c3 = Tree.node
      |> Tree.add_child(d4)
      |> Tree.add_child(d5)
      c4 = Tree.node
      |> Tree.add_child(d6)
      |> Tree.add_child(d7)
      c5 = Tree.node
      |> Tree.add_child(d8)
      c6 = Tree.node(7)
      c7 = Tree.node(1)

      b1 = Tree.node
      |> Tree.add_child(c1)
      b2 = Tree.node
      |> Tree.add_child(c2)
      |> Tree.add_child(c3)
      b3 = Tree.node
      |> Tree.add_child(c4)
      b4 = Tree.node
      |> Tree.add_child(c5)
      |> Tree.add_child(c6)
      |> Tree.add_child(c7)

      a1 = Tree.node
      |> Tree.add_child(b1)
      |> Tree.add_child(b2)
      |> Tree.add_child(b3)
      |> Tree.add_child(b4)

      assert Tree.score(a1) == 4
    end

  end

end
