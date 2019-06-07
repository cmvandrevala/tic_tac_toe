defmodule TreeNodeTest do
  use ExUnit.Case

  import TreeNode

  test "it creates a node with a value" do
    node = %TreeNode{value: 5}
    assert node.value == 5
  end

  test "it creates a node with a nil value" do
    node = %TreeNode{}
    assert node.value == nil
  end

  test "it has zero children by default" do
    node = %TreeNode{}
    assert node.children == []
  end

  test "it can have one child" do
    child = %TreeNode{value: 20}
    parent = %TreeNode{value: 40, children: [child]}
    assert parent.children == [child]
  end

  test "it can have a parent with three children" do
    child_1 = %TreeNode{value: 10}
    child_2 = %TreeNode{value: 20}
    child_3 = %TreeNode{value: 30}
    parent = %TreeNode{value: 60, children: [child_1, child_2, child_3]}

    assert parent.children == [child_1, child_2, child_3]
  end

  test "it can create a linked list" do
    child = %TreeNode{value: 10}
    parent = %TreeNode{value: 20, children: [child]}
    grandparent = %TreeNode{value: 30, children: [parent]}

    assert grandparent.children == [parent]
    assert parent.children == [child]
  end
end
