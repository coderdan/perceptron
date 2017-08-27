defmodule Perceptron1 do

  defdelegate new_trainer(dataset, l_rate), to: Perceptron1.Trainer
  defdelegate train(trainer, n_epochs), to: Perceptron1.Trainer
end
