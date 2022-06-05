defmodule FightFair.FightBehaviour do
  alias FightFair.{Action, Fight, User}

  @doc """
  Create a new Fight
  """
  @callback new(Fight.subject(), User.id()) :: {:ok, Fight.t()} | {:error, any()}

  @doc """
  Add an Action to a fight
  """
  @callback add_action(Fight.t(), Action.name(), User.id()) :: {:ok, Fight.t()} | {:error, any()}

end
