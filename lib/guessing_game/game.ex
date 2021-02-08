defmodule GuessingGame.Game do
  alias GuessingGame.{
    Game,
    Interaction,
    Messages
  }

  @type t :: %__MODULE__{
          answer: pos_integer() | nil,
          guesses: list(pos_integer()),
          max_guess_count: pos_integer() | nil,
          state: :new | :started | :win | :lose | :exit
        }

  @problem_space_mix 1
  @problem_space_max 100
  @max_guess_count 10

  defstruct answer: nil, guesses: [], max_guess_count: nil, state: :new

  def new() do
    %__MODULE__{state: :new}
  end

  @doc """
  Quit.

  Update game state to exit and do nothing.

  This function cause the game to terminate.
  """
  def step(0, game) do
    Messages.we_sad_to_see_you_go()
    |> Interaction.puts()

    %{game | state: :exit}
  end

  @doc """
  Start the game.

  Update game state to started along with initialize the game state.
  """
  def step(1, %__MODULE__{state: :new} = game) do
    # New game
    next_state = %{
      game
      | answer: Enum.random(@problem_space_min..@problem_space_max),
        guesses: [],
        max_guess_count: @max_guess_count,
        state: :started
    }

    next_state
    |> Messages.advance_the_game()
    |> Interaction.gets()
    |> Game.step(next_state)
  end

  @doc """
  Perpetuate the game.

  Continue the game until win or lose.
  """
  def step(x, %__MODULE__{state: :started, answer: answer, guesses: guesses} = game)
      when x >= @problem_space_min and x <= @problem_space_max do
    %{game | guesses: guesses ++ x}
    |> check_game_state()
    |> case do
      %__MODULE__{state: :started} = game ->
        next_state
        |> Messages.advance_the_game()
        |> Interaction.gets()
        |> Game.step(next_state)

      %__MODULE__{state: state} = game when state in [:win, :lose] ->
        game
    end
  end

  def step(_, %__MODULE__{state: :started} = game) do
    Messages.invalid_option()
    |> Interaction.puts()

    game
    |> Messages.advance_the_game()
    |> Interaction.gets()
    |> Game.step(game)
  end

  defp check_game_state(game) do
  end
end
