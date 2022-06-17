defmodule FightFair.ActionRepoBehaviour do
  @doc """
  create a new Action
  """
  @callback insert(Action.t()) :: {:ok, Action.t()} | {:error, any()}
end
