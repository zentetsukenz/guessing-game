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
          problem_space_min: pos_integer() | nil,
          problem_space_max: pos_integer() | nil,
          state: :new | :started | :win | :lose | :exit
        }

  @default_problem_space_min 1
  @default_problem_space_max 100
  @default_max_guess_count 10

  defstruct answer: nil,
            guesses: [],
            max_guess_count: nil,
            problem_space_min: nil,
            problem_space_max: nil,
            state: :new

  @spec within_problem_space(pos_integer(), pos_integer(), pos_integer()) :: Macro.t()
  defguard within_problem_space(x, min, max) when x >= min and x <= max

  @spec new :: Game.t()
  def new() do
    %__MODULE__{state: :new}
  end

  @doc """
  Step the game through a game loop.

  There are many possible choices.

  0 - Quit.
  Update game state to exit and do nothing.
  This cause the game to terminate.

  1 with game in new state - Start the game.
  Update game state to started along with initialize the game state.

  x with game in started state - Perpetuate the game.
  Continue the game until win, lose or quit the game with 0.
  """
  @spec step(pos_integer(), %Game{:state => :new | :started}) :: %Game{
          state: :win | :lose | :exit
        }
  def step(0, game) do
    game = %{game | state: :exit}

    game
    |> Messages.we_sad_to_see_you_go()
    |> Interaction.puts()

    game
  end

  def step(1, %__MODULE__{state: :new} = game) do
    game = %{
      game
      | answer: Enum.random(@default_problem_space_min..@default_problem_space_max),
        guesses: [],
        max_guess_count: @default_max_guess_count,
        problem_space_min: @default_problem_space_min,
        problem_space_max: @default_problem_space_max,
        state: :started
    }

    game
    |> Messages.advance_the_game()
    |> Interaction.gets()
    |> Game.step(game)
  end

  def step(_, %__MODULE__{state: :new} = game) do
    game
    |> Messages.invalid_option()
    |> Interaction.puts()

    Messages.start_game_option()
    |> Interaction.gets()
    |> Game.step(Game.new())
  end

  def step(
        x,
        %__MODULE__{
          state: :started,
          guesses: guesses,
          problem_space_min: min,
          problem_space_max: max
        } = game
      )
      when within_problem_space(x, min, max) do
    %{game | guesses: guesses ++ [x]}
    |> check_game_state()
    |> case do
      {end_state, game} when end_state in [:win, :lose] ->
        %{game | state: end_state}

      {hint, game} when hint in [:too_high, :too_low] ->
        hint
        |> Messages.hint()
        |> Interaction.puts()

        game
        |> Messages.advance_the_game()
        |> Interaction.gets()
        |> Game.step(game)
    end
  end

  def step(_, %__MODULE__{state: :started} = game) do
    game
    |> Messages.invalid_option()
    |> Interaction.puts()

    game
    |> Messages.advance_the_game()
    |> Interaction.gets()
    |> Game.step(game)
  end

  defp check_game_state(
         %__MODULE__{guesses: guesses, max_guess_count: maximum_allowance, answer: answer} = game
       ) do
    guessed_number = List.last(guesses)

    cond do
      length(guesses) > maximum_allowance -> {:lose, game}
      guessed_number == answer -> {:win, game}
      guessed_number > answer -> {:too_high, game}
      guessed_number < answer -> {:too_low, game}
    end
  end
end
