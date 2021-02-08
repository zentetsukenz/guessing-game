defmodule GuessingGame.GameTest do
  use ExUnit.Case

  alias GuessingGame.Game

  describe "new/0" do
    test "returns new game" do
      assert %Game{state: :new, max_guess_count: 10} == Game.new()
    end
  end

  describe "step/2" do
    setup do
      [new_game: Game.new()]
    end

    test "returns exited game", %{new_game: game} do
      assert %Game{state: :exit, max_guess_count: 10} == Game.step(0, game)
    end

    # Many tests were not possible right now due to a tightly couple between
    # interaction and the game. Until it's decouple, I won't test them.
  end
end
