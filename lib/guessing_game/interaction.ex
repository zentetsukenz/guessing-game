defmodule GuessingGame.Interaction do
  def puts(message) do
    IO.puts(message)
  end

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
