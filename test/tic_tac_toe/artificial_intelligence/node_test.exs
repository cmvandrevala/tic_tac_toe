defmodule NodeTest do
  use ExUnit.Case

  alias TicTacToe.ArtificialIntelligence.Node, as: Node

  describe "a node in a tree" do

    test "has a default value of nil" do
      node = %Node{}
      assert node.value == nil
    end

    test "has a default cell of nil" do
      node = %Node{}
      assert node.cell == nil
    end

    test "can be set with a value" do
      node = %Node{value: 7}
      assert node.value == 7
    end

    test "can be set with no children" do
      node = %Node{value: 10}
      assert node.children == []
    end

    test "can be set with one child" do
      child = %Node{value: 1}
      parent = %Node{value: 2, children: [child]}
      assert parent.children == [child]
    end

    test "can be set with many children" do
      child1 = %Node{value: 1}
      child2 = %Node{value: 2}
      parent = %Node{children: [child1, child2]}
      assert parent.children == [child1, child2]
    end

  end

end
