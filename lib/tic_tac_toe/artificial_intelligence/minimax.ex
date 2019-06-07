defmodule Minimax do

  def score(node), do: maximize(node)

  defp maximize(%TreeNode{value: nil, children: children}) do
    Enum.max(Enum.map(children, &minimize/1))
  end

  defp maximize(%TreeNode{value: value}), do: value

  defp minimize(%TreeNode{value: nil, children: children}) do
    Enum.min(Enum.map(children, &maximize/1))    
  end

  defp minimize(%TreeNode{value: value}), do: value
  
end
