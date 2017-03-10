defmodule ComputerPlayerTest do
  use ExUnit.Case
  alias TicTacToe.Core.Board, as: Board
  alias TicTacToe.ArtificialIntelligence.GameTree, as: Tree
  alias TicTacToe.ArtificialIntelligence.ComputerPlayer, as: Player

  describe "a first available spot computer player" do

    test "returns the first cell (index 0) if the board is empty" do
      assert Player.first_available_spot(Board.empty_board) == 0
    end

    test "returns the first cell (index 0) if it is available" do
      marked_board = Board.mark(Board.empty_board, 5, :p1)
      assert Player.first_available_spot(marked_board) == 0
    end

    test "returns the second cell (index 1) if it is available" do
      marked_board = Board.mark(Board.empty_board, 0, :player)
      assert Player.first_available_spot(marked_board) == 1
    end

    test "returns the third cell (index 2) if it is available" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player1)
      |> Board.mark(1, :player2)
      assert Player.first_available_spot(marked_board) == 2
    end

    test "returns the fourth cell (index 3) if it is available" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player1)
      |> Board.mark(1, :player2)
      |> Board.mark(8, :player1)
      |> Board.mark(2, :player2)
      assert Player.first_available_spot(marked_board) == 3
    end

  end

  describe "the utility measurement of a given board status" do

    test "returns 10 if the selected player wins (player one)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_one)
      |> Board.mark(2, :player_one)
      assert Player.utility(marked_board, :player_one) == 10
    end

    test "returns 10 if the selected player wins (player two)" do
      marked_board = Board.empty_board
      |> Board.mark(2, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(6, :player_two)
      assert Player.utility(marked_board, :player_two) == 10
    end

    test "returns -10 if the selected player loses (player one)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(8, :player_two)
      assert Player.utility(marked_board, :player_one) == -10
    end

    test "returns -10 if the selected player loses (player two)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(4, :player_one)
      |> Board.mark(8, :player_one)
      assert Player.utility(marked_board, :player_two) == -10
    end

    test "returns 0 if the game is a tie (player one)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      assert Player.utility(marked_board, :player_one) == 0
    end

    test "returns 0 if the game is a tie (player two)" do
      marked_board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(4, :player_two)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      assert Player.utility(marked_board, :player_two) == 0
    end

    test "returns nil for a game in progress" do
      assert Player.utility(Board.empty_board, :player_one) == nil
    end

  end

  describe "generating a game tree" do

    test "returns a node with value nil if the board is full" do
      board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_one)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_one)
      |> Board.mark(5, :player_one)
      |> Board.mark(6, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_one)
      assert Player.game_tree(board, :player_one) == Tree.node
    end

    test "returns the one remaining node if the board is almost full (first configuration)" do
      board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_two)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      |> Board.mark(7, :player_one)
      tree = Tree.add_child(Tree.node, Tree.node(0, 8))
      assert Player.game_tree(board, :player_one) == tree
    end

    test "returns the one remaining node if the board is almost full (second configuration)" do
      board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      |> Board.mark(7, :player_two)
      |> Board.mark(8, :player_one)
      tree = Tree.add_child(Tree.node, Tree.node(10, 4))
      assert Player.game_tree(board, :player_one) == tree
    end

    test "returns the one remaining node if the board is almost full (third configuration)" do
      board = Board.empty_board
      |> Board.mark(1, :player_one)
      |> Board.mark(2, :player_two)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_one)
      |> Board.mark(5, :player_two)
      |> Board.mark(6, :player_two)
      |> Board.mark(7, :player_two)
      |> Board.mark(8, :player_one)
      tree = Tree.add_child(Tree.node, Tree.node(0, 0))
      assert Player.game_tree(board, :player_two) == tree
    end

    test "returns a tree for two remaining cells (player one version)" do
      board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(2, :player_two)
      |> Board.mark(3, :player_two)
      |> Board.mark(4, :player_one)
      |> Board.mark(5, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_two)
      child1 = Tree.node(10,1)
      child = Tree.node(nil,6)
      grandchild = Tree.node(0,1)
      child2 = Tree.add_child(child, grandchild)
      tree = Tree.node
      |> Tree.add_child(child1)
      |> Tree.add_child(child2)
      assert Player.game_tree(board, :player_one) == tree
    end

    test "returns a tree for two remaining cells (player two version)" do
      board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(2, :player_two)
      |> Board.mark(3, :player_two)
      |> Board.mark(4, :player_one)
      |> Board.mark(5, :player_one)
      |> Board.mark(7, :player_one)
      |> Board.mark(8, :player_two)
      child1 = Tree.node(nil,1)
      child2 = Tree.node(nil,6)
      grandchild1 = Tree.node(0,6)
      grandchild2 = Tree.node(-10,1)
      tree = Tree.node
      |> Tree.add_child(Tree.add_child(child1, grandchild1))
      |> Tree.add_child(Tree.add_child(child2, grandchild2))
      assert Player.game_tree(board, :player_two) == tree
    end

    test "returns a tree for three remaining cells" do
      board = Board.empty_board
      |> Board.mark(0, :player_one)
      |> Board.mark(1, :player_two)
      |> Board.mark(2, :player_one)
      |> Board.mark(3, :player_one)
      |> Board.mark(4, :player_two)
      |> Board.mark(6, :player_two)
      d1 = Tree.node(0,7)
      d2 = Tree.node(0,8)
      d3 = Tree.node(0,5)
      d4 = Tree.node(0,7)
      c1 = Tree.node(-10,7)
      c2 = Tree.add_child(Tree.node(nil,8), d1)
      c3 = Tree.add_child(Tree.node(nil,5), d2)
      c4 = Tree.add_child(Tree.node(nil,8), d3)
      c5 = Tree.add_child(Tree.node(nil,5), d4)
      c6 = Tree.node(-10,7)
      b1 = Tree.node(nil,5)
      |> Tree.add_child(c1)
      |> Tree.add_child(c2)
      b2 = Tree.node(nil,7)
      |> Tree.add_child(c3)
      |> Tree.add_child(c4)
      b3 = Tree.node(nil,8)
      |> Tree.add_child(c5)
      |> Tree.add_child(c6)
      tree = Tree.node
      |> Tree.add_child(b1)
      |> Tree.add_child(b2)
      |> Tree.add_child(b3)
      assert Player.game_tree(board, :player_one) == tree
    end

  end

  describe "an unbeatable computer player" do

    test "returns the first cell if it is the first move of the game" do
      assert Player.best_spot(Board.empty_board) == 0
    end

    test "returns the center cell if it is the second move of the game and its available" do
      marked_board = Board.mark(Board.empty_board, 1, :player_one)
      assert Player.best_spot(marked_board) == 4
    end

    test "returns the first cell if it is the second move of the game and center is not available" do
      marked_board = Board.mark(Board.empty_board, 4, :player_one)
      assert Player.best_spot(marked_board) == 0
    end

  end

end
