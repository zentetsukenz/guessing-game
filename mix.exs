defmodule GuessingGame.MixProject do
  use Mix.Project

  def project do
    [
      app: :guessing_game,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: GuessingGame],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
