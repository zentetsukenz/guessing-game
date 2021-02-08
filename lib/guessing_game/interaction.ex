defmodule GuessingGame.Interaction do
  require Logger

  @spec puts(String.t()) :: :ok
  def puts(message) do
    Logger.info(message)
  end

  @spec gets(String.t()) :: :error | integer()
  def gets(prompt) do
    Logger.info(prompt)

    IO.gets(nil)
    |> String.trim()
    |> Integer.parse()
    |> case do
      {choice, _} -> choice
      :error -> :error
    end
  end
end
