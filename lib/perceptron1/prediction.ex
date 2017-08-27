defmodule Perceptron1.Prediction do
  def predict(%{row: row}, weights) do
    [bias | weights ] = weights
    bias + cross_product(row, weights)
    |> step
  end

  defp cross_product([], []), do: 0
  defp cross_product([ah | at], [bh | bt]) do
    ah * bh + cross_product(at, bt)
  end

  defp step(val) when val >= 0, do: 1
  defp step(_), do: 0
end
