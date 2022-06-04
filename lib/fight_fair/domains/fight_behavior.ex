defmodule FightFair.FightBehavior do
  alias FightFair.{Action, Fight, User}

  @doc """
  Add an Action to a fight
  """
  @callback add_action(Fight.t(), Action.name(), User.id()) :: {:ok, Fight.t()} | {:error, any()}
end
