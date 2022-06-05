defmodule FightFair.ActionBehaviour do
  @doc """
  create a new Action
  """
  @callback new(Action.name(), User.id()) :: {:ok, Action.t()} | {:error, any()}
end
