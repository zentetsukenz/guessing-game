defmodule GuessingGame do
  @moduledoc """
  Documentation for `GuessingGame`.
  """

  @doc """
  Main.

  ## Examples

      iex> GuessingGame.hello()
      :world

  """
  def main(_args) do
    command = IO.gets("Let's get started!")
    IO.puts(command)
  end
end
