defmodule GuessingGame.Messages do
  alias GuessingGame.Game

  @type t :: String.t()

  @spec welcome :: t()
  def welcome do
    ~S"""
    Welcome to the guessing game!

    In this game, you have to guess the correct number between 1 - 100.
    You have only 10 chances!

    """
  end

  @spec start_game_option :: t()
  def start_game_option do
    ~S"""
    Please select one of the option below.

    1. New game.
    2. Contribute.

    0. Quit.

    """
  end

  @spec contribute :: String.t()
  def contribute do
    ~S"""
    Please visit: https://github.com/zentetsukenz/guessing-game#contribute

    """
  end

  @spec we_sad_to_see_you_go(GuessingGame.Game.t()) :: t()
  def we_sad_to_see_you_go(%Game{state: :exit} = game) do
    ~s"""
    You still have #{guess_left_count(game)} left.
    We're sad to see you go.

    But you can come back again anytime. We will wait for you!

    """
  end

  @spec hint(:too_high | :too_low) :: t()
  def hint(:too_high) do
    ~S"""
    Oops, Your guess was HIGH.

    """
  end

  def hint(:too_low) do
    ~S"""
    Oops, Your guess was LOW.

    """
  end

  @spec advance_the_game(Game.t()) :: t()
  def advance_the_game(%Game{state: :started} = game) do
    ~s"""
    You have #{guess_left_count(game)} guesses left.
    Now, let's guess! (or 0 to quit)

    """
  end

  @spec invalid_option(Game.t()) :: t()
  def invalid_option(%Game{state: :started, problem_space_min: mix, problem_space_max: max}) do
    ~s"""
    We're sorry but your guess should be between #{mix} and #{max}.
    Please guess again. (or 0 to quit)

    """
  end

  def invalid_option(%Game{state: :new}) do
    ~s"""
    Oops, we cannot proceed with your choice.
    Please select a valid option.

    """
  end

  @spec summarize(Game.t()) :: t()
  def summarize(%Game{state: :win}) do
    ~S"""
    Good job! You guessed it!
    But I'm sure you won't guess it next time, let's play again!

    """
  end

  def summarize(%Game{state: :lose, answer: answer}) do
    ~s"""
    Sorry, You didn't guess my number. It was: #{answer}.
    But you can still make it, let's play again!

    """
  end

  defp guess_left_count(%Game{max_guess_count: maximum_allowance, guesses: guesses}) do
    maximum_allowance - length(guesses)
  end
end
