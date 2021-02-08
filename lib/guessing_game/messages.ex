defmodule GuessingGame.Messages do
  alias GuessingGame.Game

  def welcome do
    ~S"""
    Welcome to the guessing game!

    In this game, you have to guess the correct number between 1 - 100.
    You have only 10 chances!
    """
  end

  def option() do
    ~S"""
    Please select one of the option below.

    1. New game.
    2. Contribute.

    0. Quit.
    """
  end

  def we_sad_to_see_you_go do
    ~S"""
    TODO we sad to see you go
    """
  end

  def advance_the_game(%Game{state: :started} = game) do
    ~S"""
    TODO advance the game
    """
  end

  def invalid_option do
    ~S"""
    TODO invalid option
    """
  end

  def summarize(%Game{} = game) do
    ~S"""
    TODO Summarize the game
    """
  end
end
