defmodule TreeCreatorTest do
    use ExUnit.Case

    alias TicTacToe.Core.Board
    alias TicTacToe.Console.HumanPlayer

    test "it returns nil for the utility of an empty board" do
        board = Board.empty_board
        assert TreeCreator.utility(board, :player_one) == nil
    end

    test "it returns +10 if you won" do
        utility = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_one)
        |> Board.mark(2, :player_one)
        |> TreeCreator.utility(:player_one)

        assert utility == 10
    end

    test "it returns -10 if you lost" do
        utility = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_one)
        |> Board.mark(2, :player_one)
        |> TreeCreator.utility(:player_two)

        assert utility == -10
    end
    
    test "it returns 0 if the game ends in a draw" do
        utility = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_two)
        |> Board.mark(2, :player_one)
        |> Board.mark(3, :player_one)
        |> Board.mark(4, :player_two)
        |> Board.mark(5, :player_two)
        |> Board.mark(6, :player_two)
        |> Board.mark(7, :player_one)
        |> Board.mark(8, :player_one)
        |> TreeCreator.utility(:player_two)

        assert utility == 0
    end

    test "it builds a tree where the game has already ended" do
        board = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_two)
        |> Board.mark(2, :player_one)
        |> Board.mark(3, :player_one)
        |> Board.mark(4, :player_two)
        |> Board.mark(5, :player_two)
        |> Board.mark(6, :player_two)
        |> Board.mark(7, :player_one)
        |> Board.mark(8, :player_one)

        expected_tree = %TreeNode{value: 0}

        assert TreeCreator.create(board) == expected_tree
    end

    test "it builds a tree where there is one move left in the game" do
        board = Board.empty_board
        |> Board.mark(0, :player_one)
        |> Board.mark(1, :player_two)
        |> Board.mark(2, :player_one)
        |> Board.mark(3, :player_one)
        |> Board.mark(4, :player_two)
        |> Board.mark(5, :player_two)
        |> Board.mark(6, :player_two)
        |> Board.mark(7, :player_one)

        child = %TreeNode{value: 0}
        parent = %TreeNode{children: [child]}

        IO.inspect(board)
        assert TicTacToe.Core.Board.remaining_spaces(board) == 12

        assert TreeCreator.create(board) == parent
    end
end