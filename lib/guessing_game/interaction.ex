defmodule GuessingGame.Interaction do
  @spec puts(String.t()) :: :ok
  def puts(message) do
    IO.puts(message)
  end

  @spec gets(String.t()) :: :error | integer()
  def gets(prompt) do
    prompt
    |> IO.gets()
    |> String.trim()
    |> Integer.parse()
    |> case do
      {choice, _} -> choice
      :error -> :error
    end
  end
end
