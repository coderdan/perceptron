defmodule Perceptron1.Trainer do
  alias Perceptron1.Prediction
  defstruct [:dataset, :weights, :l_rate]

  def new_trainer(dataset, l_rate) do
    row_length = dataset |> Enum.take(1) |> List.first |> Map.fetch!(:row) |> length
    weights = for _ <- 0..row_length, do: 0
    %Perceptron1.Trainer{
      dataset: dataset,
      l_rate: l_rate,
      weights: weights
    }
  end

  def train(trainer, 0), do: trainer

  def train(trainer, n_epoch) do
    IO.puts("Epoch: #{n_epoch}")
    trainer
    |> Map.put(:weights, train_epoch(trainer))
    |> train(n_epoch - 1)
  end

  def train_epoch(trainer) do
    Enum.reduce trainer.dataset, trainer.weights, fn (datum, weights) ->
      prediction = Prediction.predict(datum, weights)
      error = datum.result - prediction
      correction = trainer.l_rate * error
      [ bias | wn ] = weights
      [ bias + correction | weight_correction([datum.row, wn], correction) ]
    end
  end

  def weight_correction(row_weights, correction) do
    row_weights
    |> List.zip
    |> Enum.map(fn {x, w} -> w + correction * x end)
  end
end
