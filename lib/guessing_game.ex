defmodule GuessingGame do
  @moduledoc false

  alias GuessingGame.{
    Interaction,
    Messages,
    Game
  }

  @doc false
  def main(_args) do
    Interaction.puts(Messages.welcome())

    Messages.option()
    |> Interaction.gets()
    |> Game.step(Game.new())
    |> Messages.summarize()
    |> Interaction.puts()
  end
end
