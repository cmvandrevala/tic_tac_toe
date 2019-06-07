defmodule MinimaxTest do
  use ExUnit.Case
  import TreeNode

  test "returns the score of a node with no children" do
    node = %TreeNode{value: -15}

    assert Minimax.score(node) == -15
  end

  test "returns the score of a node with one child" do
    child = %TreeNode{value: -207}
    parent = %TreeNode{children: [child]}

    assert Minimax.score(parent) == -207
  end

  test "returns the score of a linked list" do
    child = %TreeNode{value: 10}
    parent = %TreeNode{children: [child]}
    grandparent = %TreeNode{children: [parent]}

    assert Minimax.score(grandparent) == 10
  end

  test "returns the largest of two children" do
    child_1 = %TreeNode{value: 10}
    child_2 = %TreeNode{value: 20}
    parent = %TreeNode{children: [child_1, child_2]}

    assert Minimax.score(parent) == 20
  end

  test "returns the smallest grandchild" do
    child_1 = %TreeNode{value: 20}
    child_2 = %TreeNode{value: 10}
    parent = %TreeNode{children: [child_1, child_2]}
    grandparent = %TreeNode{children: [parent]}

    assert Minimax.score(grandparent) == 10
  end

  test "it returns the value of a game with four moves and only the minimizer gets to move" do
    leaf_1 = %TreeNode{value: 1}
    leaf_2 = %TreeNode{value: 0}
    leaf_3 = %TreeNode{value: 2}
    leaf_4 = %TreeNode{value: -5}
    node_level3_a = %TreeNode{children: [leaf_1, leaf_2]}
    node_level3_b = %TreeNode{children: [leaf_3, leaf_4]}
    grandchild_1 = %TreeNode{children: [node_level3_a]}
    grandchild_2 = %TreeNode{children: [node_level3_b]}
    child = %TreeNode{children: [grandchild_1, grandchild_2]}
    parent = %TreeNode{children: [child]}
    assert Minimax.score(parent) == -5
  end
end
