defmodule GuessingGame do
  @moduledoc false

  alias GuessingGame.{
    Interaction,
    Messages,
    Game
  }

  @spec main(OptionParser.argv()) :: :ok
  def main(_args) do
    Interaction.puts(Messages.welcome())

    Messages.start_game_option()
    |> Interaction.gets()
    |> Game.step(Game.new())
    |> Messages.summarize()
    |> Interaction.puts()
  end
end
