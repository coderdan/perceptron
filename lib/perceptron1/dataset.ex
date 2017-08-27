defmodule Perceptron1.Dataset do
  defstruct [:row, :result]

  @dataset [
            %{row: [2.7810836,2.550537003], result: 0},
            %{row: [1.465489372,2.362125076], result: 0},
            %{row: [3.396561688,4.400293529], result: 0},
            %{row: [1.38807019,1.850220317], result: 0},
            %{row: [3.06407232,3.005305973], result: 0},
            %{row: [7.627531214,2.759262235], result: 1},
            %{row: [5.332441248,2.088626775], result: 1},
            %{row: [6.922596716,1.77106367], result: 1},
            %{row: [8.675418651,-0.242068655], result: 1},
            %{row: [7.673756466,3.508563011], result: 1}
  ]

  @weights  [-0.1, 0.20653640140000007, -0.23418117710000003]

  def dataset(), do: @dataset
  def weights(), do: @weights

  def load(filename) do
    filename
    |> File.stream!
    |> CSV.decode!
    |> Stream.map(fn row -> List.pop_at(row, -1) end)
    |> Stream.map(fn {result,values} ->
      # FIXME: We could totally just use tuples for dataset records
      values = Enum.map(values, &String.to_float/1)
      case result do
        "M" -> %Perceptron1.Dataset{result: 1, row: values}
        _   -> %Perceptron1.Dataset{result: 0, row: values}
      end
    end)
  end
end
